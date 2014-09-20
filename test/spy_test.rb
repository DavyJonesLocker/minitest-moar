require 'test_helper'

class SpyTest < Minitest::Test
  def test_spy_works
    person = Person.new

    stub Book, :read do
      person.read_book(Book)
    end

    assert_called Book, :read
  end

  def test_spy_call_count
    person = Person.new

    stub Book, :read do
      person.read_book(Book)
      person.read_book(Book)
    end

    assert_called Book, :read, 2
  end

  def test_refute_spy
    refute_called Book, :read
  end

  def test_refute_spy_call_count
    person = Person.new

    stub Book, :read do
      person.read_book(Book)
      person.read_book(Book)
    end

    refute_called Book, :read, 1
  end

  def test_instance_spy_works
    person = Person.new

    instance_stub Book, :read do
      person.read_book(Book.new)
    end

    assert_instance_called Book, :read
  end

  def test_instance_spy_call_count
    person = Person.new

    instance_stub Book, :read do
      person.read_book(Book.new)
      person.read_book(Book.new)
    end

    assert_instance_called Book, :read, 2
  end

  def test_refute_instance_spy
    refute_called Book, :read
  end

  def test_refute_instance_spy_call_count
    person = Person.new

    instance_stub Book, :read do
      person.read_book(Book.new)
      person.read_book(Book.new)
    end

    refute_instance_called Book, :read, 1
  end
end
