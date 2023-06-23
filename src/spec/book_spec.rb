require_relative '../library/book'
require_relative '../library/rental'
require 'date'

describe Book do
  let(:book) { Book.new('Title', 'Author') }
  let(:person) { double('Person', rentals: []) }
  let(:date) { Date.new(2023, 1, 1) }

  describe '#initialize' do
    it 'creates a new book with the given title and author' do
      expect(book.title).to eq('Title')
      expect(book.author).to eq('Author')
      expect(book.rentals).to be_empty
    end
  end

  describe '#add_rental' do
    it 'creates a new rental for the book with the given person and date' do
      rental = book.add_rental(person, date)
      expect(rental).to be_an_instance_of(Rental)
      expect(rental.date).to eq(date)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
    end
  end

  describe '#to_hash' do
    it 'returns a hash representation of the book' do
      hash = book.to_hash
      expect(hash).to be_a(Hash)
      expect(hash[:title]).to eq('Title')
      expect(hash[:author]).to eq('Author')
    end
  end

  describe '.from_hash' do
    it 'creates a new book from a hash representation' do
      hash = { title: 'Title', author: 'Author' }
      book = Book.from_hash(hash)
      expect(book).to be_an_instance_of(Book)
      expect(book.title).to eq('Title')
      expect(book.author).to eq('Author')
      expect(book.rentals).to be_empty
    end
  end
end
