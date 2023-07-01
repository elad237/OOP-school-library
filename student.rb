require_relative 'person'

class Student < Person
  attr_reader :classroom
  attr_accessor :role

  def initialize(age, classroom, name = 'Ezra', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
    @role = 'student'
    classroom.add_student(self) if classroom.is_a?(Classroom) && !classroom.students.include?(self)
  end

  def attributes
    {
      id: @id,
      name: @name,
      age: @age,
      parent_permission: @parent_permission,
      rentals: @rentals,
      classroom: @classroom,
      role: @role
    }
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.add_student(self) unless classroom.students.include?(self)
  end
end
