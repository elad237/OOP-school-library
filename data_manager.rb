require 'json'
require 'fileutils'

module DataManager
  def save_data
    create_data_directory
    save_books
    save_people
    save_rentals
  end

  DATA_DIR = 'data'.freeze
  BOOKS_FILE = "#{DATA_DIR}/books.json".freeze
  PEOPLE_FILE = "#{DATA_DIR}/people.json".freeze
  RENTALS_FILE = "#{DATA_DIR}/rentals.json".freeze

  def create_data_directory
    FileUtils.mkdir_p(DATA_DIR)
  end

  def save_books
    book_data = @books.map { |book| { 'title' => book.title, 'author' => book.author } }
    File.write(BOOKS_FILE, JSON.generate(book_data))
  end

  def save_people
    people_data = @people.map do |person|
      attributes = person.attributes
      attributes['classroom'] = person.classroom.name if person.is_a?(Student) && person.classroom.is_a?(Classroom)
      attributes
    end

    File.write(PEOPLE_FILE, JSON.generate(people_data))
  end

  def save_rentals
    rental_data = @rentals.map do |rental|
      { 'date' => rental.date, 'book_id' => rental.book.id, 'person_id' => rental.person.id }
    end

    File.write(RENTALS_FILE, JSON.generate(rental_data))
  end

  def load_data
    load_books
    load_people
    load_rentals
  end

  def load_books
    book_data = load_data_from_file(BOOKS_FILE)
    @books = book_data.nil? ? [] : book_data.map { |book_info| Book.new(book_info['title'], book_info['author']) }
  end

  def load_people
    people_data = load_data_from_file(PEOPLE_FILE)
    @people = if people_data.nil?
                []
              else
                people_data.map do |person_info|
                  if person_info['role'] == 'student'
                    student = Student.new(person_info['age'], person_info['classroom'], person_info['name'],
                                          parent_permission: person_info['parent_permission'])
                    student.role = 'student'
                    student
                  else
                    teacher = Teacher.new(person_info['age'], person_info['specialization'], person_info['name'])
                    teacher.role = 'teacher'
                    teacher
                  end
                end
              end
  end

  def load_rentals
    rental_data = load_data_from_file(RENTALS_FILE)
    @rentals = []
    rental_data&.each do |rental_info|
      book = find_book_by_id(rental_info['book_id'])
      person = find_person_by_id(rental_info['person_id'])
      if book && person
        rental = Rental.new(rental_info['date'], book, person)
        @rentals << rental
      end
    end
  end

  def find_book_by_id(book_id)
    @books.find { |book| book.id == book_id }
  end

  def find_person_by_id(person_id)
    @people.find { |person| person.id == person_id }
  end

  def load_data_from_file(filename)
    return unless File.exist?(filename)

    data = File.read(filename)
    JSON.parse(data)
  end
end
