class Employee
  attr_accessor :name, :title, :salary, :boss
  
  def initialize(name, title, salary, boss)
    @name, @title, @salary, @boss = name, title, salary, boss
    boss.add_subordinate(self) unless boss.nil?
  end
  
  def bonus(multiplier)
    salary * multiplier
  end
  
  def total_sub_salary
    0
  end
end

class Manager < Employee
  attr_reader :subordinates
  
  def initialize(name, title, salary, boss)
    super(name, title, salary, boss)
    @subordinates = []
  end
  
  def add_subordinate(employee)
    subordinates << employee
  end
  
  def total_sub_salary
    total_sub_salaries = 0
    subordinates.each do |subordinate|
      total_sub_salaries += subordinate.salary + subordinate.total_sub_salary
    end
    total_sub_salaries
  end
  
  def bonus(multiplier)
    total_sub_salary * multiplier
  end
end

# ceo = Manager.new('eline', 'top dog', 1_000_000, nil)
# ned = Manager.new('ned', 'teacher', 100_000, ceo)
# david = Employee.new('david', 'working grunt', 10_000, ned)
# matt = Employee.new('matt', 'working grunt', 12_000, ned)
#
# p david.salary
#
# p ned.subordinates
#
# p ned.total_sub_salary
#
# p ceo.total_sub_salary
#
# p ceo.bonus(5)
#
# p david.bonus(3)

