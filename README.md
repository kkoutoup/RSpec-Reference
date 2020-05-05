# RSpec-Reference
A quick reference for writing and running tests with RSpec for Ruby

## Purpose
Putting this together as I'm learning TDD with Ruby and RSpec

## Resources
[RSpec on Github](https://github.com/rspec)

## Installation
1. Install the gem ```gem install rspec```
2. Create the file structure
3. In the project's root directory use the ```rspec --init``` to create a configuration file ```.rspec``` and a ```spec_helper.rb``` file inside the ```spec``` folder.

## File structure
```
lib
  |__file_name.rb
spec
  |__file_name_spec.rb
  |__spec_helper.rb
.rspec
```

## Flags
The following flags should follow the name of your spec file i.e. `my_spec.rb --color`. These flags can also be part of your ```.rspec``` file.

| Flag          | Short for Flag        | Result        |
| ------------- |:-------------:|:-------------:|
| `--color` | `-c` | Applies green/red color for successful/failing tests|
| `--no-color` | N/A |Tests don't have color |
| `--format progress` | `-f p` | One dot (.) for each test that passes or one 'F' for each failing test |
| `--format documentation` | `-f d` | Detailed decriptions for each test |
| `--order random` | N/A | Runs tests in random order |
| `--profile` | `-p` | Gives timings for slower examples |
| `--fail fast` | N/A | Stops at first failing test |
| `:line_number` | N/A | i.e. `my_spec.rb:3` will run tests for code on line 3 |

### Example Class
```ruby
class Car

  attr_reader :make
  attr_accessor :model, :year, :specifications

  def initialize(make, model, year, specifications = nil)
    @make = make
    @model = model
    @year = year
    @specifications = specifications
  end

  def self.categories # class method
    ["sedan", "coupe", "suv", "convertible", "hatchback", "sports", "station wagon"]
  end

  def format_make
    @make = @make.capitalize
  end
  
  def format_model
    @model = @model.split(" ").map { |word| word.capitalize }.join(" ")
  end
  

  def present_car
    "A #{@year} #{@make} #{@model}"
  end

  def old?
    @year.to_i < 2015
  end

  def set_specifications(transmission, fuel_type)
    @specifications = {transmission: transmission, fuel_type: fuel_type}
  end
end
```
### expect(). to eq()

#### instance attributes
```ruby
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
end
```

#### instance methods
```ruby
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

describe "#present_car" do # use # for instance methods
  it "should return a string with the car's year make and model" do
    car = Car.new("Honda", "Civic", "2000")
    expect(car.present_car).to eq("A 2000 Honda Civic")
  end
end
```

### expect().to match(regex)
```ruby
describe "#present_car" do
  it "should match a regular expression" do
    car = Car.new("Honda", "Civic", "2000")
    expect(car.present_car).to match(/^A\s\d+\s[A-Z]\w+\s[A-Z]\w+$/)
  end
end
```

### expect().to be true/false
```ruby
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
```

### expect().to be / expect().to_not be
```ruby
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
```

### expect().to be_instance_of(class)
```ruby
describe "a new car" do
  it "should be an instance of the parent class" do
    car = Car.new("Lancia", "Delta", "1987")
    expect(car).to be_instance_of(Car)
  end
end
```

### expect().to be_a(n) Class
```ruby
describe "parent class method Car.categories" do  
  it "should be of type array" do
    expect(Car.categories).to be_an Array
  end

  it "should be an array of strings" do
    expect(Car.categories.all?(String)).to be true
  end
end

describe "instance attribute year" do
  it "should be of type String" do
    car = Car.new("Toyota", "Avensis", "2019")
    expect(car.year).to be_a String
  end
end
```

```ruby
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
```