require_relative './library/book'
require_relative './library/rental'
require_relative './person/teacher'
require_relative './person/student'
require_relative './storage/lib_storage'

class App
  def initialize
    @storage = LibraryStorage.new
    @people = @storage.load_poeple
    @books = @storage.load_books
    @rentals = @storage.load_rentals(@people, @books)
  end

  def list_all_books(select: false)
    puts '========================================================================='
    @books.each_with_index do |book, idx|
      puts "#{select ? "#{idx}) " : ''}Title: \"#{book.title}\", Author: #{book.author}"
    end
    puts '========================================================================='
  end

  def list_all_people(select: false)
    puts '========================================================================='
    @people.each_with_index do |person, idx|
      role = person.is_a?(Teacher) ? 'Teacher' : 'Student'
      puts "#{select ? "#{idx}) " : ''}[#{role}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    puts '========================================================================='
  end

  def create_student(age, name, parent_permission)
    @people << Student.new(age, name, parent_permission: parent_permission)
  end

  def create_teacher(age, name, specialization)
    @people << Teacher.new(age, specialization, name)
  end

  def create_book(title, author)
    @books << Book.new(title, author)
  end

  def create_rental(book_id, person_id, date)
    book = @books[book_id]
    person = @people[person_id]
    @rentals << person.add_rental(book, date)
  end

  def list_rentals_for_person(person_id)
    person = @people.find do |p|
      p.id == person_id
    end
    return unless person

    puts 'Rentals'
    person.rentals.each do |rental|
      puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
    end
  end

  def before_exit
    @storage.save_poeple(@people)
    @storage.save_books(@books)
    @storage.save_rentals(@rentals)
  end
end
