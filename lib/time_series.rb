# Copyright (c) 2015 GreenSync Pty Ltd.  All rights reserved.

class TimeSeries

  def initialize
    @data = []
  end

  def empty?
    @data.empty?
  end

  def first_timestamp
    return nil if empty?

    @data.map(&:first).min
  end

  def last_timestamp
    return nil if empty?

    @data.map(&:first).max
  end

  def [](timestamp)
    return nil if empty?

    @data.each do |existing_timestamp, value|
      return value if existing_timestamp == timestamp
    end

    nil
  end

  def []=(timestamp, value)
    raise "timestamp must be a Time" unless timestamp.is_a?(Time)
    raise "timestamp must be UTC" unless timestamp.utc?

    unless value.nil?
      # insert in place if already there
      @data.each do |pair|
        if pair.first == timestamp
          pair[1] = value
          return value
        end
      end

      # otherwise, add to end
      @data << [timestamp, value]
      return value
    else
      @data.delete_if { |existing_timestamp, _| timestamp == existing_timestamp }
      return nil
    end
  end

end