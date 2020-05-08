require_relative "../lib/car.rb"

describe "Car" do
  describe "reading and writing object attributes" do
    # create an instance
    car = Car.new("Honda", "Civic", "2000")

    it "should allow read access to :make" do
      expect(car.make).to eq("Honda")
    end

    it "should allow read and write access to :model" do
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
    it "should capitalize every word in a car's :model" do
      car = Car.new("Honda", "type r", "2000")
      expect(car.format_model).to eq("Type R")
    end
  end
  
  describe "#present_car" do # use # to refer to instance methods
    it "should return a string with the car's :year, :make and :model" do
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

  describe "Car.new" do
    it "should be an instance of the parent class Car" do
      car = Car.new("Lancia", "Delta", "1987")
      expect(car).to be_instance_of(Car)
    end
  end

  describe ".categories method" do  
    it "should return an array" do
      expect(Car.categories).to be_an Array
    end

    it "should return an array of strings" do
      expect(Car.categories.all?(String)).to be true
    end
  end

  describe "instance attribute year" do
    it "should be of type String" do
      car = Car.new("Toyota", "Avensis", "2019")
      expect(car.year).to be_a String
    end
  end

  describe "#set_specifications should return a hash " do

    it "should have a :transmission key" do
      car = Car.new("BMW", "Z4", "2015")
      car.set_specifications("manual", "unleaded") 
      expect(car.specifications).to include(:transmission)
    end

    it "should have a :fuel_type key" do
      car = Car.new("BMW", "Z4", "2015")
      car.set_specifications("manual", "unleaded")
      expect(car.specifications).to include(:fuel_type)
    end

    it "should return key-value pairs" do
      car = Car.new("BMW", "Z4", "2015")
      car.set_specifications("manual", "unleaded")
      expect(car.specifications).to include(transmission: "manual")
      expect(car.specifications).to include(fuel_type: "unleaded")
    end
  end

  describe "car instance" do
    car = Car.new("porsche", "911", 2018)
    it "should respond to #format_make" do
      expect(car).to respond_to(:format_make)
    end
  end

  describe "make" do
    car = Car.new("porsche", "911", 2018)
    it "should not allow modification of :make" do
      expect(car).not_to respond_to(:make=)
    end
  end

  describe "previous accidents" do
    car = Car.new("mercedes", "CLK-250", 2019)
    it "instance should not have access to previous accidents from outside" do
      expect(car).not_to respond_to(:previous_accidents)
    end
  end

  describe "car instance" do
    car = Car.new("porsche", "911", 2019)
    it "should have attributes :make, :model, :year" do
      expect(car).to have_attributes(make: "porsche")
      expect(car).to have_attributes(model: "911")
      expect(car).to have_attributes(year: "2019")
    end
  end

  describe "car instance" do
    car = Car.new("porsche", "911", 2019, {transmission: "auto", fuel_type: "diesel"})
    context "specifications" do
      it "should have :transmission and :fuel_type keys" do
        expect(car.specifications).to have_key(:transmission)
        expect(car.specifications).to have_key(:fuel_type)
      end
      it ":transmission and :fuel_type keys should have corresponding values" do
        expect(car.specifications).to have_value("auto")
        expect(car.specifications).to have_value("diesel")
      end
    end
  end
end

describe Car do
  context "using let to define class instances for testing" do
    let(:bmw) {Car.new("BMW", "Z4", 2014)}
    let(:porsche) {Car.new("porsche", "911", 2017)}
    let(:honda) {Car.new("honda", "type r", 2019, {transmission: "auto", fuel_type: "unleaded"})}

    describe "#old?" do
      context "when the year is before 2015" do
        it "should return true" do
          expect(bmw.old?).to be true
        end
      end

      context "when the year is after 2015" do
        it "should return false" do
          expect(porsche.old?).to be false
          expect(honda.old?).to be false
        end
      end
    end

    describe "#format_model" do
      it "should format the car :model" do
        expect(honda.format_model).to eq("Type R")
      end
    end
  end
end

describe Car do
  context "using .send to test private methods" do
    let(:bmw) {Car.new("BMW", "Z4", 2014)}
    describe "car.add_to_previous_accidents" do
      it "should add a accident log hash to @previous_accidents" do
        bmw.send(:add_to_previous_accidents, {year: 2018, severe: true})
        expect(bmw.instance_variable_get(:@previous_accidents).length).to eq(1)
        expect(bmw.instance_variable_get(:@previous_accidents)[0]).to have_key(:year)
        expect(bmw.instance_variable_get(:@previous_accidents)[0]).to have_key(:severe)
        expect(bmw.instance_variable_get(:@previous_accidents)[0][:year]).to be(2018)
        expect(bmw.instance_variable_get(:@previous_accidents)[0][:severe]).to be true
      end
    end
  end
end
