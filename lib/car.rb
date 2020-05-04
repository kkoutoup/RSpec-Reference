class Car

  attr_reader :make
  attr_accessor :model, :year

  def initialize(make, model, year)
    @make = make
    @model = model
    @year = year
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
end
