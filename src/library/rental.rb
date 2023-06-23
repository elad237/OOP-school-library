class Rental
  attr_accessor :date, :person, :book

  def initialize(date, book, person)
    @date = date
    @person = person
    person.rentals << self
    @book = book
    book.rentals << self
  end

  def to_hash
    { date: @date, person: @person.name, book: @book.title }
  end
end
