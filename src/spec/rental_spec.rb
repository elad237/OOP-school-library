require_relative '../library/rental'

describe Rental do
  let(:person) { double('Person', name: 'john', rentals: []) }
  let(:book) { double('Book', title: 'waters', rentals: []) }
  let(:rental) { Rental.new('2023-02-30', book, person) }

  it('should initialize the instance with given attributes') do
    expect(rental).to be_an_instance_of(Rental)
    expect(rental.date).to eq '2023-02-30'
    expect(rental.person).to be person
    expect(rental.book).to be book
  end

  it('should add it self to rentals list of person and book') do
    expect(person.rentals).to include rental
    expect(book.rentals).to include rental
  end

  it('should create the hash of rental') do
    expected_hash = { date: '2023-02-30', person: 'john', book: 'waters' }
    hash = rental.to_hash
    expect(hash).to eql expected_hash
  end
end
