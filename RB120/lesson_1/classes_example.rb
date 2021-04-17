class MyCar
  attr_accessor :color
  attr_reader :year
  def initialize(year, color, model)
    @year = year
    @color = color 
    @model = model
    @speed = 0
  end

  def speed_up(number)
    @speed += number
    puts "You push the gas and accelarate #{number} mph."
  end

  def brake(number)
    @speed -= number
    puts "You push the brake and decelarate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@speed} mph"
  end

  def shut_off
    @speed = 0
    puts "Let's park this bad boy!"
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def to_s
    "My car is a #{color}, #{year}, #{@model}!"
  end
end

accord = MyCar.new(2019, "Honda Accord", "Silver")
puts accord

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"