require './classroom'
require './student'
require './book'
require './rental'
require 'date'

# Create classrooms
classroom1 = Classroom.new('Classroom 1')
classroom2 = Classroom.new('Classroom 2')

# Create students
student1 = Student.new(15, classroom1, 'John Doe')
student2 = Student.new(16, classroom1, 'Jane Smith')
student3 = Student.new(17, classroom2, 'Mike Johnson')

# Create books
book1 = Book.new('Book 1', 'Author 1')
book2 = Book.new('Book 2', 'Author 2')

# Create rentals
rental1 = Rental.new(Date.today, book1, student1)
rental2 = Rental.new(Date.today, book1, student2)
rental3 = Rental.new(Date.today, book2, student3)

# Test relationships and functionality
puts "Classroom 1 students: #{classroom1.students.map(&:name)}"
puts "Classroom 2 students: #{classroom2.students.map(&:name)}"

puts "Book 1 rentals: #{book1.rentals.map { |r| "#{r.person.name} (#{r.date})" }}"
puts "Book 2 rentals: #{book2.rentals.map { |r| "#{r.person.name} (#{r.date})" }}"

puts "#{student1.name} can use services: #{student1.can_use_services?}"
puts "#{student3.name} can use services: #{student3.can_use_services?}"

puts "#{student2.name} playing hooky: #{student2.play_hooky}"
