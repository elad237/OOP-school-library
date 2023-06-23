class PersonCreator
  def initialize(app)
    @app = app
  end

  def create_person
    print 'Do you want to create a stduent (1) or a teacher (2)? [Input the number]: '
    choice = gets.chomp
    if choice == '1'
      create_student
    elsif choice == '2'
      create_teacher
    else
      puts 'Invalid choice'
    end
  end

  private

  def create_student
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp.downcase == 'y'
    @app.create_student(age, name, permission)
    puts 'Person created successfully'
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    @app.create_teacher(age, name, specialization)
    puts 'Person created successfully'
  end
end
