module Delegable
  def delegate(to_whom, activities_to_delegate)
    activity_name = self.activities.pop() #activities_to_delegate could change the method fo find the activitu
    to_whom.activities << activity_name
    puts "You have delegated #{activity_name} activy to #{to_whom} "
  end
end


class Employee 
  def initialize(name, serial_number) 
    @name = name
    @serial_number = serial_number
    @activities = []
  end

  def to_s
    puts "Name: #{@name}"
    puts "Type: #{self.class}"
    puts "Serial Number: #{@serial_number}"
    puts "Vacation days: #{@vacations}"
    puts "Desk: #{@desk}"
  end
end

class FullTimeEmployee < Employee
  def initialize(name, serial_number)
    super
    @vacations = 10
    @desk = "Cubic Farm"
  end

  def take_vacation(days)
    @vacations -= days
    puts "Enjoy your vacations #{days} days"
  end
end

class PartTimeEmployee < Employee
  def initialize(name, serial_number)
    super
    @vacations = 0
    @desk = "Open Workspace"
  end
end

class Executives < FullTimeEmployee

  include Delegable

  def initialize(name, serial_number)
    super
    @vacations = 20
    @desk = "Corner Office"
  end
end

class Managers < FullTimeEmployee

  include Delegable

  def initialize(name, serial_number)
    super
    @vacations = 14
    @desk = "Private Office"
  end
end