class Menu
  OPTIONS = {
    1 => :list_all_books,
    2 => :list_all_people,
    3 => :create_person,
    4 => :create_book,
    5 => :create_rental,
    6 => :list_rentals_for_person,
    7 => :exit_app
  }.freeze

  def initialize(app)
    @app = app
  end

  def display_menu_options
    puts 'Please select an option:'
    OPTIONS.each do |key, value|
      puts "#{key}. #{menu_option_name(value)}"
    end
  end

  def handle_choice(choice)
    if OPTIONS.key?(choice)
      send(OPTIONS[choice])
    else
      puts 'Invalid option. Please try again.'
    end
  end

  private

  def menu_option_name(method_name)
    method_name.to_s.split('_').map(&:capitalize).join(' ')
  end

  def list_all_books
    @app.list_all_books
  end

  def list_all_people
    @app.list_all_people
  end

  def create_person
    @app.create_person_menu
  end

  def create_book
    @app.create_book
  end

  def create_rental
    @app.create_rental
  end

  def list_rentals_for_person
    @app.list_rentals_for_person
  end

  def exit_app
    puts 'Exiting the app. Goodbye!'
  end
end
