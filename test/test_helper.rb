require 'minitest/autorun'
require 'minitest/moar'
require 'byebug'

class Book
  def self.read
  end

  def read
  end
end

class Person
  def read_book(book)
    book.read
  end
end

class Dog < BasicObject
  def name
    'Boomer'
  end
end

module Project
  def self.name
    'Best Project Evar'
  end
end
