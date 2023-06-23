require_relative('./app')
require_relative('./operations/library_operations')
require_relative('./operations/person_operations')

class AllOperations
  def initialize
    @app = App.new
    @library = LibraryActions.new(@app)
    @person = PersonCreator.new(@app)
  end

  def list_all_books
    @library.list_all_books
  end

  def list_all_people
    @library.list_all_people
  end

  def create_book
    @library.create_book
  end

  def create_rentals
    @library.create_rentals
  end

  def list_rentals
    @library.list_rentals
  end

  def create_person
    @person.create_person
  end

  def exit
    @app.before_exit
  end
end
