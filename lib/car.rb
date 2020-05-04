class Car
  attr_reader :make, :model
  attr_writer :model
  attr_accessor :year

  def initialize(make, model, year)
    @make = make
    @model = model
    @year = year
  end

  def present_car
    "A #{@year} #{@make} #{@model}"
  end
  

end