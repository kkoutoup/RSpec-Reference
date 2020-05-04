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

  describe "#format_make" do
    it "should capitalize the car's :make" do
      car = Car.new("honda", "civic", "2000")
      expect(car.format_make).to eq("Honda")
    end
  end

  describe "#format_model" do
    it "should capitalize every word in a car's model" do
      car = Car.new("Honda", "type r", "2000")
      expect(car.format_model).to eq("Type R")
    end
  end
  
  describe "#present_car" do # use # to refer to instance methods
    it "should return a string with the car's year, make and model" do
      car = Car.new("Honda", "Civic", "2000")
      expect(car.present_car).to eq("A 2000 Honda Civic")
    end
  end

  describe "#present_car" do
    it "should match a regular expression" do
      car = Car.new("Honda", "Civic", "2000")
      expect(car.present_car).to match(/^A\s\d+\s[A-Z]\w+\s[A-Z]\w+$/)
    end
  end

  describe "#old?" do # user ? for methods that return boolean
    context "when the year is before 2015" do
      it "should return true" do
        car = Car.new("Nissan", "Sunny", "2007")
        expect(car.old?).to be true
      end
    end

    context "when the year is after 2015" do
      it "should return false" do
        car = Car.new("Nissan", "Navara", "2015")
        expect(car.old?).to be false
      end
    end
  end

  describe "#old?" do
    context "when the year is before 2015" do
      it "should return true" do
        car = Car.new("Nissan", "Sunny", "2007")
        expect(car).to be_old
      end
    end

    context "when the year is after 2015" do
      it "should return false" do
        car = Car.new("Nissan", "Navara", "2015")
        expect(car).to_not be_old
      end
    end
  end
end
