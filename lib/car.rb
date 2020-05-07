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
end
