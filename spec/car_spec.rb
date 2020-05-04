require_relative "../lib/car"
require "rspec"

describe "Car" do
  describe "#full_name" do
    it "allows reading and writing for :make" do
      car = Car.new("Honda")
      expect(car.make).to eq("Honda")
    end
  end
end
