# Copyright (c) 2015 GreenSync Pty Ltd.  All rights reserved.

require 'csv'
#require 'eventmachine'
#require 'em-synchrony'



class DataLoader
  
  $aggregate = TimeSeries.new
  DATA_DIR = File.expand_path('../../data', __FILE__)

  TIMESTAMP_REGEX = %r{\A(\d{4})/(\d{2})/(\d{2}) (\d{2}):(\d{2}):(\d{2})\z}
  PRICE_REGEX = %r{\A(-)?(\d+)(?:.(?:(\d{2})|(\d)))?\z}



  def row_processing partition_row
    #puts "."
      partition_row.each do |row|
        timestamp = parse_timestamp(row['SETTLEMENTDATE'])
        value = parse_price(row['RRP'])
        #time_series[timestamp] = value
        $aggregate[timestamp] = value
        #$aggregate[parse_timestamp(row['SETTLEMENTDATE'])] = parse_price(row['RRP'])
      end
  end
 

  def event_machine file_array
      EM.synchrony do
      concurrency = 6
      @counter = 0
    # iterator will execute async blocks completion of block
        results = EM::Synchrony::Iterator.new(file_array,concurrency).map do |file, iter|
          puts "-"
            CSV.foreach(file, headers: true) do |row|
              timestamp = parse_timestamp(row['SETTLEMENTDATE'])
              value = parse_price(row['RRP'])
              $aggregate[timestamp] = value
            end
            @counter = @counter +1 
            return if @counter >= 4
        end
      end
  end

  def parallel file_array

    file_array.each do |path|
    puts "."
    data = CSV.read(path,headers: true)
    p_data = data.each_slice(400).to_a
    mutex = Mutex.new
    threads = []
    threads = (p_data).map do |p|
      Thread.new(p) do |p|
        mutex.synchronize do 
          row_processing ( p )
        end
      end
    end
    threads.each {|t| t.join}
    end
  end

   def synchronous file_array
    file_array.each do |path|
      puts "."
      data = CSV.read(path,headers: true)
      p_data = data.each_slice(400).to_a
        p_data.map do |p|
          row_processing ( p )
        end
      end
    end

    def synchronous_unpartitioned file_array
      file_array.each do |path|
        puts "."
        CSV.foreach(path, headers: true) do |row|
            $aggregate[parse_timestamp(row['SETTLEMENTDATE'])] = parse_price(row['RRP'])
        end
      end
    end

  def parse_timestamp(timestamp_string)
    raise "invalid timestamp #{timestamp_string}" unless timestamp_string =~ TIMESTAMP_REGEX

    Time.utc($1.to_i, $2.to_i, $3.to_i, $4.to_i, $5.to_i, $6.to_i)
  end

  def parse_price(price_string)
    raise "invalid price #{price_string}" unless price_string =~ PRICE_REGEX

    ($1 ? -1 : 1) * ($2.to_i * 100 + ($3 ? $3.to_i : $4.to_i * 10))
  end

  def load_series

    time_series = TimeSeries.new
    t = Time.now
    Dir.glob(File.join(DATA_DIR, 'DATA??????_VIC1.csv')) do |filename|
      #STDERR.puts "Loading #{filename}..."
      puts "."
        
        CSV.foreach(filename, headers: true) do |row|
            timestamp = parse_timestamp(row['SETTLEMENTDATE'])
            value = parse_price(row['RRP'])
            time_series[timestamp] = value
        end
    end
    puts Time.now - t
    time_series
  end
       

  def thread_loader
    # breaking the file name array into three equal chunks 
      file_names = Dir.glob(File.join(DATA_DIR, 'DATA??????_VIC1.csv'))
      puts file_names.size
      partition = file_names.each_slice(4).to_a
      tt = Time.now

      mutex = Mutex.new
      threads = []
      threads = (partition).map do |partitions|
        # multi threading to process the contents of the file
        Thread.new(partitions) do |partitions|
          mutex.synchronize do 
            #event_machine ( partitions )
            #parallel ( partitions )
            synchronous_unpartitioned ( partitions )
          end
        end
      end

      threads.each {|t| t.join}
      puts Time.now - tt
      $aggregate
    end

    def pool
      # avoids the needs of implementing mutex as Queues are thread safe
      file_names = Dir.glob(File.join(DATA_DIR, 'DATA??????_VIC1.csv'))
      puts file_names.size
      partition = file_names.each_slice(4).to_a

      jobs = Queue.new

      partition.each do |partitions|
        jobs.push partitions
      end
      t1 = Time.now
      workers = 12.times.map do
        Thread.new do
          begin      
            while x = jobs.pop(true)
              synchronous_unpartitioned x       
            end
          rescue ThreadError
          end
        end
      end

      workers.map(&:join)
      puts Time.now - t1
      $aggregate
    end

end

