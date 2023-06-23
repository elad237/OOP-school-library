require_relative '../person/person'
require_relative '../library/rental'

describe Person do
  let(:person) { Person.new(20, 'John Doe') }
  let(:book) { double('Book', rentals: []) }
  let(:date) { Date.new(2023, 1, 1) }

  describe '#initialize' do
    it 'creates a new person with the given age, name, and parent permission' do
      expect(person.age).to eq(20)
      expect(person.name).to eq('John Doe')
      expect(person.rentals).to be_empty
    end

    it 'assigns a random ID between 1 and 255' do
      expect(person.id).to be_between(1, 255)
    end

    it "defaults the name to 'Unknown' if not provided" do
      person = Person.new(25)
      expect(person.name).to eq('Unknown')
    end
  end

  describe '#add_rental' do
    it 'creates a new rental for the person with the given book and date' do
      rental = person.add_rental(book, date)
      expect(rental).to be_an_instance_of(Rental)
      expect(rental.date).to eq(date)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
    end
  end

  describe '#correct_name' do
    it 'returns the correct name of the person' do
      expect(person.correct_name).to eq('John Doe')
    end
  end

  describe '#can_use_services?' do
    context 'when the person is of age' do
      it 'returns true' do
        person = Person.new(18)
        expect(person.can_use_services?).to be true
      end
    end

    context 'when the person is not of age but has parent permission' do
      it 'returns true' do
        person = Person.new(16, 'Jane Smith', parent_permission: true)
        expect(person.can_use_services?).to be true
      end
    end

    context 'when the person is not of age and does not have parent permission' do
      it 'returns false' do
        person = Person.new(16, 'Jane Smith', parent_permission: false)
        expect(person.can_use_services?).to be false
      end
    end
  end
end
