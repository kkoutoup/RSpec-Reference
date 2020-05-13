# RSpec-Reference
A quick reference for writing and running tests with RSpec for Ruby

## Purpose
Putting this together as I'm learning TDD with Ruby and RSpec

## Contents
+ [Installation](https://github.com/kkoutoup/RSpec-Reference#installation)
+ [File structure](https://github.com/kkoutoup/RSpec-Reference#file-structure)
+ [Flags](https://github.com/kkoutoup/RSpec-Reference#flags)
+ [Example Class](https://github.com/kkoutoup/RSpec-Reference#example-class)
+ [expect()](https://github.com/kkoutoup/RSpec-Reference#expect)
  + [expect().to eq()](https://github.com/kkoutoup/RSpec-Reference#expectto-eq)
  + [expect().to match(regex)](https://github.com/kkoutoup/RSpec-Reference#expectto-matchregex)
  + [expect().to be true/false](https://github.com/kkoutoup/RSpec-Reference#expectto-be-truefalse)
  + [expect().to be / expect().to_not be](https://github.com/kkoutoup/RSpec-Reference#expectto-be--expectto_not-be)
  + [expect().to be_instance_of(Class)](https://github.com/kkoutoup/RSpec-Reference#expectto-be_instance_ofclass)
  + [expect().to be_a(n) Class](https://github.com/kkoutoup/RSpec-Reference#expectto-be_an-class)
  + [expect().to include()](https://github.com/kkoutoup/RSpec-Reference#expectto-include)
  + [expect().to respond_to() / .not_to respond_to()](https://github.com/kkoutoup/RSpec-Reference#expectto-respond_to--not_to-respond_to)
  + [expect().to have_attributes()](https://github.com/kkoutoup/RSpec-Reference#expectto-have_attributes)
  + [expect().to have_key() / expect().to have_value()](https://github.com/kkoutoup/RSpec-Reference#expectto-have_key--have_value)
+ [let(){}](https://github.com/kkoutoup/RSpec-Reference#let)
+ [send() && instance_variable_get()](https://github.com/kkoutoup/RSpec-Reference#send--instance_variable_get)
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
.rubocop.yml [*optional file for rubocop mods]
```
*[Rubocop default configuration](https://github.com/rubocop-hq/rubocop/blob/master/config/default.yml)

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

## Example Class
```ruby
class LogError < StandardError
end

class Car

  attr_reader :make
  attr_accessor :model, :year, :specifications

  def initialize(make, model, year, specifications = nil)
    @make = make
    @model = model
    @year = year.to_s
    @specifications = specifications
    @previous_accidents = []
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
    @specifications = { transmission: transmission, fuel_type: fuel_type }
  end

  private

  def add_to_previous_accidents(args={})
    # should return an error if args is empty
    fail LogError, "No information provided" if args.empty?

    accident_log = args
    @previous_accidents << accident_log
  end
end
```
## expect()
### expect().to eq()

#### instance attributes
```ruby
describe 'Car' do
  describe 'reading and writing object attributes' do
    # create an instance
    car = Car.new('Honda', 'Civic', '2000')

    it 'should allow read access to :make' do
      expect(car.make).to eq('Honda')
    end

    it 'should allow write access to :model' do
      car.model = 'Type-R'
      expect(car.model).to eq('Type-R')
    end

    it 'should allow read and write access to :year' do
      expect(car.year).to eq('2000')
      car.year = '2005'
      expect(car.year).to eq('2005')
    end
  end
end
```

#### instance methods
```ruby
describe '#format_make' do
  it 'should capitalize the car :make' do
    car = Car.new('honda', 'civic', '2000')
    expect(car.format_make).to eq('Honda')
  end
end

describe '#format_model' do
  it 'should capitalize every word in a car model' do
    car = Car.new('Honda', 'type r', '2000')
    expect(car.format_model).to eq('Type R')
  end
end

describe '#present_car' do # use # for instance methods
  it 'should return a string with the car year make and model' do
    car = Car.new('Honda', 'Civic', '2000')
    expect(car.present_car).to eq('A 2000 Honda Civic')
  end
end
```

### expect().to match(regex)
```ruby
describe '#present_car' do
  it 'should match a regular expression' do
    car = Car.new('Honda', 'Civic', '2000')
    expect(car.present_car).to match(/^A\s\d+\s[A-Z]\w+\s[A-Z]\w+$/)
  end
end
```

### expect().to be true/false
```ruby
describe '#old?' do # user ? for methods that return boolean
  context 'when the year is before 2015' do
    it 'should return true' do
      car = Car.new('Nissan', 'Sunny', '2007')
      expect(car.old?).to be true
    end
  end

  context 'when the year is after 2015' do
    it 'should return false' do
      car = Car.new('Nissan', 'Navara', '2015')
      expect(car.old?).to be false
    end
  end
end
```

### expect().to be / .to_not be
```ruby
describe '#old?' do
  context 'when the year is before 2015' do
    it 'should return true' do
      car = Car.new('Nissan', 'Sunny', '2007')
      expect(car).to be_old
    end
  end

  context 'when the year is after 2015' do
    it 'should return false' do
      car = Car.new('Nissan', 'Navara', '2015')
      expect(car).to_not be_old
    end
  end
end
```

### expect().to be_instance_of(Class)
```ruby
describe 'a new car' do
  it 'should be an instance of the parent class' do
    car = Car.new('Lancia', 'Delta', '1987')
    expect(car).to be_instance_of(Car)
  end
end
```

### expect().to be_a(n) Class
```ruby
describe 'parent class method Car.categories' do
  it 'should be of type array' do
    expect(Car.categories).to be_an Array
  end

  it 'should be an array of strings' do
    expect(Car.categories.all?(String)).to be true
  end
end

describe 'instance attribute year' do
  it 'should be of type String' do
    car = Car.new('Toyota', 'Avensis', '2019')
    expect(car.year).to be_a String
  end
end
```
### expect().to include()
```ruby
describe '#set_specifications should return a hash ' do
  it 'should have a :transmission key' do
    car = Car.new('BMW', 'Z4', '2015')
    car.set_specifications('manual', 'unleaded')
    expect(car.specifications).to include(:transmission)
  end

  it 'should have a :fuel_type key' do
    car = Car.new('BMW', 'Z4', '2015')
    car.set_specifications('manual', 'unleaded')
    expect(car.specifications).to include(:fuel_type)
  end

  it 'should return key-value pairs' do
    car = Car.new('BMW', 'Z4', '2015')
    car.set_specifications('manual', 'unleaded')
    expect(car.specifications).to include(transmission: 'manual')
    expect(car.specifications).to include(fuel_type: 'unleaded')
  end
end
```
### expect().to respond_to() / .not_to respond_to()
```ruby
describe 'make' do
  car = Car.new('porsche', '911', 2018)
  it 'should not allow modification of make' do
    expect(car).not_to respond_to(:make=)
  end
end

describe 'previous accidents' do
  car = Car.new('mercedes', 'CLK-250', 2019)
  it 'instance should not have access to previous accidents from outside' do
    expect(car).not_to respond_to(:previous_accidents)
  end
end
```
```ruby
describe 'car instance' do
  car = Car.new('porsche', '911', 2018)
  it 'should respond to #format_make' do
    expect(car).to respond_to(:format_make)
  end
end
```
### expect().to have_attributes()
```ruby
describe 'car instance' do
  car = Car.new('porsche', '911', 2019)
  it 'should have attributes make, model, year' do
    expect(car).to have_attributes(make: 'porsche')
    expect(car).to have_attributes(model: '911')
    expect(car).to have_attributes(year: '2019')
  end
end
```
### expect().to have_key() / have_value()
```ruby
describe 'car instance' do
  car = Car.new('porsche', '911', 2019, { transmission: 'auto', fuel_type: 'diesel' })
  context 'specifications' do
    it 'should have :transmission and :fuel_type keys' do
      expect(car.specifications).to have_key(:transmission)
      expect(car.specifications).to have_key(:fuel_type)
    end
    it ':transmission and :fuel_type keys should have corresponding values' do
      expect(car.specifications).to have_value('auto')
      expect(car.specifications).to have_value('diesel')
    end
  end
end
```
## let(){}
```ruby
describe Car do
  let(:bmw) { Car.new('BMW', 'Z4', 2014) }
  let(:porsche) { Car.new('porsche', '911', 2017) }
  let(:honda) { Car.new('honda', 'type r', 2019, { transmission: 'auto', fuel_type: 'unleaded' }) }

  describe '#old?' do
    context 'when the year is before 2015' do
      it 'should return true' do
        expect(bmw.old?).to be true
      end
    end

    context 'when the year is after 2015' do
      it 'should return false' do
        expect(porsche.old?).to be false
        expect(honda.old?).to be false
      end
    end
  end

  describe '#format_model' do
    it 'should format the car :model' do
      expect(honda.format_model).to eq('Type R')
    end
  end
end
```
## send() && instance_variable_get()
```ruby
describe Car do
  context 'using .send to test private methods' do
    let(:bmw) { Car.new('BMW', 'Z4', 2014) }
    describe 'car.add_to_previous_accidents' do
      it 'should add a accident log hash to @previous_accidents' do
        bmw.send(:add_to_previous_accidents, { year: 2018, severe: true })
        expect(bmw.instance_variable_get(:@previous_accidents).length).to eq(1)
        expect(bmw.instance_variable_get(:@previous_accidents)[0]).to have_key(:year)
        expect(bmw.instance_variable_get(:@previous_accidents)[0]).to have_key(:severe)
        expect(bmw.instance_variable_get(:@previous_accidents)[0][:year]).to be(2018)
        expect(bmw.instance_variable_get(:@previous_accidents)[0][:severe]).to be true
      end
    end
  end
end
```