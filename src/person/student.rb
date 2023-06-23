require_relative('./person')

class Student < Person
  attr_reader :classroom

  def initialize(age, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def to_hash
    { age: @age, name: @name, parent_permission: @parent_permission, type: 'student' }
  end

  def self.from_hash(hash)
    new(hash.values[0], hash.values[1], parent_permission: hash.values[2])
  end
end
