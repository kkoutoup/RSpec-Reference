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

### expect(). to eq()
#### instance attributes
```ruby
class Car
  attr_reader :make, :model
  attr_writer :model
  attr_accessor :year

  def initialize(make, model, year)
    @make = make
    @model = model
    @year = year
  end
end
```

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
describe "#present_car" do # use # to refer to instance methods
  it "should return a string with the car's year make and model" do
    car = Car.new("Honda", "Civic", "2000")
    expect(car.present_car).to eq("A 2000 Honda Civic")
  end
end
```