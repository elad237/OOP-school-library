require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require_relative 'classroom'
require_relative 'data_manager'

class App
  include DataManager

  def initialize
    @books = []
    @people = []
    @rentals = []
    @next_person_id = 1
    @next_rental_id = 1
  end

  def list_all_books
    puts '---------------------------------------------'
    puts 'List of all books:'
    @books.each_with_index do |book, index|
      puts "#{index + 1}. Title: '#{book.title}' Author: #{book.author}"
    end
    puts '---------------------------------------------'
  end

  def list_all_people
    puts '---------------------------------------------'
    puts 'List of all people:'
    @people.each_with_index do |person, index|
      role = person.is_a?(Student) ? 'Student' : 'Teacher'
      puts "#{index + 1}. [#{role}] #{person.name} (ID: #{person.id}) Age: #{person.age}"
    end
    puts '---------------------------------------------'
  end

  def create_person_menu
    puts 'Do you want to create a student (1) or a teacher (2)?) [put the number]'
    role = gets.chomp.to_i

    case role
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid role. Please try again.'
    end
  end

  def create_student
    puts "Enter the student's name:"
    name = gets.chomp

    puts "Enter the student's age:"
    age = gets.chomp.to_i

    puts 'Does the student have parent permission? (y/n)'
    parent_permission_input = gets.chomp.downcase
    parent_permission = parent_permission_input == 'y'

    student = Student.new(age, nil, name, parent_permission: parent_permission)
    student.role = 'student' # Add this line to set the role as "student"
    @people << student
    @next_person_id += 1

    puts 'Person created successfully'
  end

  def create_teacher
    puts "Enter the teacher's name:"
    name = gets.chomp

    puts "Enter the teacher's age:"
    age = gets.chomp.to_i

    puts "Enter the teacher's specialization:"
    specialization = gets.chomp

    teacher = Teacher.new(age, specialization, name)
    teacher.role = 'teacher' # Add this line to set the role as "teacher"
    @people << teacher
    @next_person_id += 1

    puts 'Person created successfully'
  end

  def create_book
    puts "Enter the book's title:"
    title = gets.chomp
    puts "Enter the book's author:"
    author = gets.chomp
    book = Book.new(title, author)
    @books << book
    puts 'Book created successfully'
  end

  def create_rental
    book = select_book
    return if book.nil?

    person = select_person
    return if person.nil?

    puts 'Enter the rental date (e.g., YYYY-MM-DD):'
    date = gets.chomp

    rental = Rental.new(@next_rental_id, date, book, person)
    @rentals << rental
    @next_rental_id += 1 # Increment the next rental ID

    puts 'Rental created successfully'
  end

  def select_book
    puts 'Available books:'
    list_all_books

    puts 'Enter the number corresponding to the book:'
    book_number = gets.chomp.to_i

    book = @books[book_number - 1]

    puts 'Invalid book number. Please try again.' if book.nil?

    book
  end

  def select_person
    puts 'Available people:'
    list_all_people

    puts 'Enter the number corresponding to the person:'
    person_number = gets.chomp.to_i

    person = @people[person_number - 1]

    puts 'Invalid person number. Please try again.' if person.nil?

    person
  end

  def list_rentals_for_person
    puts "Enter the person's ID:"
    person_id = gets.chomp.to_i
    person = find_person(person_id)
    if person
      rentals = Rental.rentals_for_person(person_id)
      puts '---------------------------------------------'
      puts "Rentals for person #{person.name} (ID: #{person.id}):"
      rentals.each do |rental|
        puts " '#{rental.book.title}' by: #{rental.book.author} (Rental Date: #{rental.date})"
      end
    else
      puts 'Person not found. Please check the ID.'
    end
    puts '---------------------------------------------'
  end

  private

  def find_book(title)
    @books.find { |book| book.title == title }
  end

  def find_person(id)
    @people.find { |person| person.id == id }
  end
end
