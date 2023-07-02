class Rental
  attr_accessor :date, :book, :person

  @rentals = [] # Class instance variable to store all rentals

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person

    @book.rentals << self
    @person.rentals << self
    self.class.rentals << self
  end

  class << self
    attr_reader :rentals
  end

  def self.rentals_for_person(person_id)
    rentals.select { |rental| rental.person.id == person_id }
  end
end

