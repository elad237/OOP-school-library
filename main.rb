require_relative 'app'
require_relative 'menu'
require_relative 'data_manager'

def main
  app = App.new
  menu = Menu.new(app)

  app.load_data

  loop do
    menu.display_menu_options
    choice = gets.chomp.to_i

    menu.handle_choice(choice)

    break if choice == 7
  end

  app.save_data
end

main
