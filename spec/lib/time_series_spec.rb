# Copyright (c) 2015 GreenSync Pty Ltd.  All rights reserved.

require 'spec_helper'

describe TimeSeries do

  let(:series) { TimeSeries.new }

  context "after construction" do
    it "should be empty" do
      expect(series).to be_empty
    end

    it "should have no first timestamp" do
      expect(series.first_timestamp).to be_nil
    end

    it "should have no last timestamp" do
      expect(series.last_timestamp).to be_nil
    end
  end

  describe "#[]=" do
    let(:timestamp) { Time.now.utc }
    let(:value) { rand(123) }

    subject { series[timestamp] = value }

    context "into an empty series" do
      it "should make the series non-empty" do
        expect { subject }.to change { series.empty? }.from(true).to(false)
      end

      it "should become the first timestamp" do
        expect { subject }.to change { series.first_timestamp }.from(nil).to(timestamp)
      end

      it "should become the last timestamp" do
        expect { subject }.to change { series.last_timestamp }.from(nil).to(timestamp)
      end

      it "should return the value from that timestamp" do
        expect { subject }.to change { series[timestamp] }.from(nil).to(value)
      end
    end

    context "into a series with timestamp existing" do
      let(:existing_value) { rand(123) + 123 }

      before do
        series[timestamp] = existing_value
      end

      it "should not change the emptiness" do
        expect { subject }.not_to change { series.empty? }
      end

      it "should become the first timestamp" do
        expect { subject }.not_to change { series.first_timestamp }
      end

      it "should become the last timestamp" do
        expect { subject }.not_to change { series.last_timestamp }
      end

      it "should return the value from that timestamp" do
        expect { subject }.to change { series[timestamp] }.from(existing_value).to(value)
      end

      context "and removing it" do
        let(:value) { nil }

        it "should make the series empty" do
          expect { subject }.to change { series.empty? }.from(false).to(true)
        end

        it "should remove the first timestamp" do
          expect { subject }.to change { series.first_timestamp }.from(timestamp).to(nil)
        end

        it "should become the last timestamp" do
          expect { subject }.to change { series.last_timestamp }.from(timestamp).to(nil)
        end

        it "should return the value from that timestamp" do
          expect { subject }.to change { series[timestamp] }.from(existing_value).to(nil)
        end
      end
    end
  end

  describe "#[]" do
    let(:timestamp) { Time.now.utc }
    let(:value) { rand(123) + 123 }

    before do
      (0..10).each { |t| series[Time.at(t).utc] = rand(123) }
      series[timestamp] = value
      (20..30).each { |t| series[Time.at(t).utc] = rand(123) }
    end

    subject { series[timestamp] }

    it "should return the value from the timestamp" do
      expect(subject).to eq(value)
    end

  end

  context "populated with some data" do
    before do
      (0..10).to_a.shuffle.each { |t| series[Time.at(t * 1000).utc] = rand(123) }
    end

    describe "#first_timestamp" do
      subject { series.first_timestamp }

      it "should return the first timestamp" do
        expect(subject).to eq(Time.at(0).utc)
      end
    end

    describe "#last_timestamp" do
      subject { series.last_timestamp }

      it "should return the last timestamp" do
        expect(subject).to eq(Time.at(10_000).utc)
      end
    end
  end

end