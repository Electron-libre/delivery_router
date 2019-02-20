require_relative "../spec_helper.rb"

describe Rider do
  let(:rider) { Rider.new(id: 1, x: 2, y: 5, speed: 10) }
  let(:restaurant) { Restaurant.new(id: 1, x: 5, y: 1, cooking_time: 35) }

  describe "#distance_to" do
    subject { rider.distance_to(restaurant) }

    it "compute the distance with another location" do
      expect(subject).to eql 5.0
    end
  end

  describe "#time_to" do
    subject { rider.time_to(restaurant) }

    it "compute the time to travel to location in minutes" do
      expect(subject).to eql 30.0
    end
  end
end
