require_relative '../person/teacher'
require_relative '../person/person'

describe Teacher do
  let(:teacher) { Teacher.new(25, 'Physics', 'John Doe') }

  context 'Initialization and attributes' do
    it 'should be subtype of Person' do
      expect(teacher).to be_a_kind_of(Person)
    end

    it 'The teacher object should be created successfully' do
      expect(teacher).to be_an_instance_of(Teacher)
      expect(teacher.name).to eq 'John Doe'
      expect(teacher.age).to eq 25
      expect(teacher.specialization).to eq 'Physics'
    end
  end
  context 'Methods' do
    it 'should return true for can_use_services' do
      expect(teacher.can_use_services?).to be true
    end

    it 'should return the correct hash using to_hash method' do
      expected_hash = { age: 25, specialization: 'Physics', name: 'John Doe', type: 'teacher' }
      hash = teacher.to_hash
      expect(hash).to eql expected_hash
    end

    it 'should create a valid instance from given hash' do
      instance_hash = { age: 35, specialization: 'Mathimatics', name: 'John Doe', type: 'teacher' }
      teacher_instance = Teacher.from_hash(instance_hash)

      expect(teacher_instance).to be_an_instance_of(Teacher)
      expect(teacher_instance.name).to eq 'John Doe'
      expect(teacher_instance.age).to eq 35
      expect(teacher_instance.specialization).to eq 'Mathimatics'
    end
  end
end
