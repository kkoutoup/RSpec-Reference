require_relative "../lib/car.rb"

describe "Car" do
  describe "reading and writing object attributes" do
    # create an instance
    car = Car.new("Honda", "Civic", "2000")

    it "should allow read access to :make" do
      expect(car.make).to eq("Honda")
    end

    it "should allow write access to :model" do
      car.model = "Type-R"
      expect(car.model).to eq("Type-R")
    end

    it "should allow read and write access to :year" do
      expect(car.year).to eq("2000")
      car.year = "2005"
      expect(car.year).to eq("2005")
    end
  end

  describe "#old?" do
    # create an instance
    car = Car.new("Honda", "Civic", "2000")
    
    context "when year is before 2015" do
      it "should return true" do
        expect(car.old?).to be_old
      end
    end
  end
  

end
