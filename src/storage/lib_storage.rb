require_relative './storage'
require_relative '../person/student'
require_relative '../person/teacher'
require_relative '../library/book'
require_relative '../library/rental'

class LibraryStorage
  def initialize
    @people_key = 'people'
    @books_key = 'books'
    @rentals_key = 'rentals'
  end

  def save_poeple(people)
    Storage.save_data(people.map { |person| person&.to_hash }, @people_key)
  end

  def save_books(books)
    Storage.save_data(books.map { |book| book&.to_hash }, @books_key)
  end

  def save_rentals(rentals)
    Storage.save_data(rentals.map { |rental| rental&.to_hash }, @rentals_key)
  end

  def load_poeple
    data = Storage.load_data(@people_key)
    return [] unless data

    data.map do |person|
      if person['type'] == 'student'
        Student.from_hash(person)
      else
        Teacher.from_hash(person)
      end
    end
  end

  def load_books
    data = Storage.load_data(@books_key)
    return [] unless data

    data.map do |book|
      Book.from_hash(book)
    end
  end

  def load_rentals(people, books)
    data = Storage.load_data(@rentals_key)
    return [] unless data

    data.map do |rental|
      Rental.new(rental['date'], books.find { |book| book.title == rental['book'] },
                 people.find { |person| person.name == rental['person'] })
    end
  end
end
