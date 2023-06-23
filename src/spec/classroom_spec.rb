require_relative '../library/classroom'

describe Classroom do
  let(:classroom) { Classroom.new('Maths') }
  let(:student) { double('Student') }
  it 'should initialize the instance correctly' do
    expect(classroom).to be_an_instance_of Classroom
  end

  it 'should have the correct label and empty array of students' do
    expect(classroom.label).to eq 'Maths'
    expect(classroom.students).to be_empty
  end

  it 'adds a student to the classroom and sets the classroom for student' do
    expect(student).to receive(:classroom=).with(classroom)
    classroom.add_student(student)
    expect(classroom.students).to include(student)
  end
end
