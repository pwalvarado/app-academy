class Student
  attr_reader :first_name, :last_name
  attr_accessor :courses
  
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end
  
  def name
    "#{ first_name } #{ last_name }"
  end
  
  def enroll(course)
    unless courses.include?(course)
      courses << course
      course.add_student(self)
    end
  end
  
  def course_load
    course_load = Hash.new(0)
    courses.each do |course|
      course_load[course.department] += 1
    end
    
    course_load
  end
  
  def to_s
    name
  end
end


class Course
  attr_reader :name, :department, :no_of_credits
  attr_accessor :students
  
  def initialize(name, department, no_of_credits)
    @name = name
    @department = department
    @no_of_credits = no_of_credits
    @students = []
  end
  
  def add_student(student)
    student.enroll(self)
    students << student unless students.include?(student)
  end
end

# david = Student.new('david','runger')
# matt = Student.new('matt','graser')
# algebra = Course.new('Algebra', 'Math', 3)
# comp_sci = Course.new('Computer Science', 'Math', 4)
# lit = Course.new('English Literature', 'English', 3)
# david.enroll(algebra)
# david.enroll(comp_sci)
# david.enroll(lit)
# puts david.course_load
# lit.add_student(matt)
# puts lit.students
# puts matt.course_load
