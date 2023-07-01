class Book
  attr_reader :title, :author, :id

  def initialize(title, author)
    @title = title
    @author = author
    @id = self.class.generate_next_id
  end

  def self.generate_next_id
    @next_id ||= 1
    @next_id += 1
  end
end
