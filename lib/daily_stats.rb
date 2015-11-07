# Copyright (c) 2015 GreenSync Pty Ltd.  All rights reserved.

class DailyStats

  def initialize(time_series)
    @time_series = time_series
  end

  def values(midnight)
    (1..48).map do |interval|
      @time_series[midnight + interval * 30 * 60]
    end
  end

  def min_max_avg(midnight)
    values = values(midnight)

    [values.min, values.max, (values.inject(&:+) / values.length.to_f).round,median(values),variance(values).round,std_deviation(values).round]
  end

  def median values
    # sort the array in ascending order
    #find and return the middle element
    values = values.sort
    values[values.length/2] if values.length.even?
    values[(values.length/2) + 1]
  end

  def variance values
    # calculate mean
    # calculate summation of array element minus mean squared
    # divide by total number of elements
    mean = values.inject(0){ |sum,next_element| sum + next_element }.to_f / values.length 
    total = 0
    values.each do |i|
      total = total + (i - mean) ** 2
    end
    return total / (values.length).to_f
  end

  def std_deviation values
    # standard deviation is squre root of variance
     Math.sqrt(variance(values))
  end

  def each
    midnight = @time_series.first_timestamp - 30 * 60

    while midnight < @time_series.last_timestamp
      yield midnight, *min_max_avg(midnight)
      midnight += 24 * 60 * 60
    end
  end
end          