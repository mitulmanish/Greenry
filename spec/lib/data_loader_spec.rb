# Copyright (c) 2015 GreenSync Pty Ltd.  All rights reserved.

require 'spec_helper'

describe DataLoader do

  let(:loader) { DataLoader.new }

  describe "#parse_timestamp" do
    it "should parse" do
      expect(loader.parse_timestamp('2014/04/12 12:45:32')).to eq(Time.utc(2014, 4, 12, 12, 45, 32))
    end
  end

  describe "#parse_price" do
    {
      '39.1' => 3910,
      '39.10' => 3910,
      '39.0' => 3900,
      '39.00' => 3900,
      '39.01' => 3901,
      '-39.01' => -3901,
      '42' => 4200
    }.each do |input, expected_output|
      it "should parse #{input} to #{expected_output}" do
        expect(loader.parse_price(input)).to eq(expected_output)
      end
    end
  end

end