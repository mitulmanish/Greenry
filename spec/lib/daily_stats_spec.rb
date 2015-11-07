# Copyright (c) 2015 GreenSync Pty Ltd.  All rights reserved.

require 'spec_helper'

describe DailyStats do

  let(:datapoints) do
    [
      [Time.utc(2014, 3, 12,  0, 30), 123],
      [Time.utc(2014, 3, 12,  1,  0),  12],
      [Time.utc(2014, 3, 12,  1, 30), 123],
      [Time.utc(2014, 3, 12,  2,  0), 123],
      [Time.utc(2014, 3, 12,  2, 30), 123],
      [Time.utc(2014, 3, 12,  3,  0), 123],
      [Time.utc(2014, 3, 12,  3, 30), 567],
      [Time.utc(2014, 3, 12,  4,  0), 123],
      [Time.utc(2014, 3, 12,  4, 30), 123],
      [Time.utc(2014, 3, 12,  5,  0), 144],
      [Time.utc(2014, 3, 12,  5, 30), 123],
      [Time.utc(2014, 3, 12,  6,  0), 123],
      [Time.utc(2014, 3, 12,  6, 30), 123],
      [Time.utc(2014, 3, 12,  7,  0), 600],
      [Time.utc(2014, 3, 12,  7, 30), 123],
      [Time.utc(2014, 3, 12,  8,  0), 123],
      [Time.utc(2014, 3, 12,  8, 30), 123],
      [Time.utc(2014, 3, 12,  9,  0), 577],
      [Time.utc(2014, 3, 12,  9, 30), 698],
      [Time.utc(2014, 3, 12, 10,  0), 123],
      [Time.utc(2014, 3, 12, 10, 30), 123],
      [Time.utc(2014, 3, 12, 11,  0), 123],
      [Time.utc(2014, 3, 12, 11, 30), 123],
      [Time.utc(2014, 3, 12, 12,  0), 435],
      [Time.utc(2014, 3, 12, 12, 30), 123],
      [Time.utc(2014, 3, 12, 13,  0), 123],
      [Time.utc(2014, 3, 12, 13, 30), 766],
      [Time.utc(2014, 3, 12, 14,  0), 123],
      [Time.utc(2014, 3, 12, 14, 30), 123],
      [Time.utc(2014, 3, 12, 15,  0), 123],
      [Time.utc(2014, 3, 12, 15, 30), 123],
      [Time.utc(2014, 3, 12, 16,  0),  45],
      [Time.utc(2014, 3, 12, 16, 30), 123],
      [Time.utc(2014, 3, 12, 17,  0), 123],
      [Time.utc(2014, 3, 12, 17, 30), 123],
      [Time.utc(2014, 3, 12, 18,  0), 453],
      [Time.utc(2014, 3, 12, 18, 30), 123],
      [Time.utc(2014, 3, 12, 19,  0), 345],
      [Time.utc(2014, 3, 12, 19, 30), 123],
      [Time.utc(2014, 3, 12, 20,  0), 775],
      [Time.utc(2014, 3, 12, 20, 30), 123],
      [Time.utc(2014, 3, 12, 21,  0), 675],
      [Time.utc(2014, 3, 12, 21, 30), 123],
      [Time.utc(2014, 3, 12, 22,  0), 123],
      [Time.utc(2014, 3, 12, 22, 30), 123],
      [Time.utc(2014, 3, 12, 23,  0), 555],
      [Time.utc(2014, 3, 12, 23, 30), 123],
      [Time.utc(2014, 3, 13,  0,  0), 122],

      [Time.utc(2014, 3, 13,  0, 30),  14],
      [Time.utc(2014, 3, 13,  1,  0),  11],
      [Time.utc(2014, 3, 13,  1, 30), 123],
      [Time.utc(2014, 3, 13,  2,  0), 123],
      [Time.utc(2014, 3, 13,  2, 30), 123],
      [Time.utc(2014, 3, 13,  3,  0), 123],
      [Time.utc(2014, 3, 13,  3, 30), 567],
      [Time.utc(2014, 3, 13,  4,  0), 123],
      [Time.utc(2014, 3, 13,  4, 30), 123],
      [Time.utc(2014, 3, 13,  5,  0), 144],
      [Time.utc(2014, 3, 13,  5, 30), 123],
      [Time.utc(2014, 3, 13,  6,  0), 123],
      [Time.utc(2014, 3, 13,  6, 30), 123],
      [Time.utc(2014, 3, 13,  7,  0), 600],
      [Time.utc(2014, 3, 13,  7, 30), 123],
      [Time.utc(2014, 3, 13,  8,  0), 123],
      [Time.utc(2014, 3, 13,  8, 30), 123],
      [Time.utc(2014, 3, 13,  9,  0), 577],
      [Time.utc(2014, 3, 13,  9, 30), 699],
      [Time.utc(2014, 3, 13, 10,  0), 123],
      [Time.utc(2014, 3, 13, 10, 30), 123],
      [Time.utc(2014, 3, 13, 11,  0), 123],
      [Time.utc(2014, 3, 13, 11, 30), 123],
      [Time.utc(2014, 3, 13, 12,  0), 435],
      [Time.utc(2014, 3, 13, 12, 30), 123],
      [Time.utc(2014, 3, 13, 13,  0), 123],
      [Time.utc(2014, 3, 13, 13, 30), 999],
      [Time.utc(2014, 3, 13, 14,  0), 123],
      [Time.utc(2014, 3, 13, 14, 30), 123],
      [Time.utc(2014, 3, 13, 15,  0), 123],
      [Time.utc(2014, 3, 13, 15, 30), 123],
      [Time.utc(2014, 3, 13, 16,  0),  45],
      [Time.utc(2014, 3, 13, 16, 30), 123],
      [Time.utc(2014, 3, 13, 17,  0), 123],
      [Time.utc(2014, 3, 13, 17, 30), 123],
      [Time.utc(2014, 3, 13, 18,  0), 453],
      [Time.utc(2014, 3, 13, 18, 30), 123],
      [Time.utc(2014, 3, 13, 19,  0), 345],
      [Time.utc(2014, 3, 13, 19, 30), 123],
      [Time.utc(2014, 3, 13, 20,  0), 775],
      [Time.utc(2014, 3, 13, 20, 30), 123],
      [Time.utc(2014, 3, 13, 21,  0), 675],
      [Time.utc(2014, 3, 13, 21, 30), 123],
      [Time.utc(2014, 3, 13, 22,  0), 123],
      [Time.utc(2014, 3, 13, 22, 30), 123],
      [Time.utc(2014, 3, 13, 23,  0), 555],
      [Time.utc(2014, 3, 13, 23, 30), 123],
      [Time.utc(2014, 3, 14,  0,  0), 122],

    ]
  end

  let(:series) do
    TimeSeries.new.tap do |series|
      datapoints.each { |(t, v)| series[t] = v}
    end
  end

  let(:stats) { DailyStats.new(series) }
  let(:midnight) { Time.utc(2014, 3, 12,  0,  0) }

  describe "#values" do
    subject { stats.values(midnight) }

    it "should return the 48 points from that day" do
      expect(subject).to eq([123, 12, 123, 123, 123, 123, 567, 123, 123, 144, 123, 123, 123, 600, 123, 123, 123, 577, 698, 123, 123, 123, 123, 435, 123, 123, 766, 123, 123, 123, 123,  45, 123, 123, 123, 453, 123, 345, 123, 775, 123, 675, 123, 123, 123, 555, 123, 122])
    end
  end

  describe "#min_max_avg" do
    subject { stats.min_max_avg(midnight) }

    it "should return the 48 points from that day" do
      expect(subject).to eq([12, 775, 226])
    end
  end

  describe "#each" do
    subject do
      result = []
      stats.each { |*a| result << a }
      result
    end

    it "should return the correct days and data" do
      expect(subject).to eq(
        [
          [Time.utc(2014, 3, 12,  0,  0), 12, 775, 226],
          [Time.utc(2014, 3, 13,  0,  0), 11, 999, 228],
        ]
      )
    end
  end

end