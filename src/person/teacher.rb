require_relative('./person')

class Teacher < Person
  attr_reader :specialization

  def initialize(age, specialization, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end

  def to_hash
    { age: @age, specialization: @specialization, name: @name, type: 'teacher' }
  end

  def self.from_hash(hash)
    new(hash.values[0], hash.values[1], hash.values[2])
  end
end
