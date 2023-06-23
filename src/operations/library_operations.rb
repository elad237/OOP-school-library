class LibraryActions
  def initialize(app)
    @app = app
  end

  def create_rentals
    puts 'Select a book from the following list by number'
    @app.list_all_books(select: true)
    book_idx = gets.chomp.to_i
    puts "\nSelect a person from the following list by number (not id)"
    @app.list_all_people(select: true)
    person_idx = gets.chomp.to_i
    print "\nDate: "
    date = gets.chomp
    @app.create_rental(book_idx, person_idx, date)
    puts 'Rental created successfully'
  end

  def list_all_books
    @app.list_all_books
  end

  def list_all_people
    @app.list_all_people
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @app.create_book(title, author)
    puts 'Book created successfully'
  end

  def list_rentals
    print 'ID of person: '
    person_id = gets.chomp.to_i
    puts '========================================================================='
    @app.list_rentals_for_person(person_id)
    puts '========================================================================='
  end
end
