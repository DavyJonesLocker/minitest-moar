require 'test_helper'

class StubbingTest < Minitest::Test
  def test_no_object_stub
    refute Object.respond_to?(:stub)
    refute Object.new.respond_to?(:stub)
  end

  def test_stub_method_exists
    assert self.respond_to?(:stub)
  end

  def test_instance_stub_method_exists
    assert self.respond_to?(:instance_stub)
  end

  def test_stub_method_works
    person = Person.new

    @called = 0
    caller = Proc.new { @called += 1 }

    stub Book, :read, caller do
      person.read_book(Book)
    end

    assert_equal 1, @called
  end

  def test_instance_stub_method_works
    person = Person.new

    @called = 0
    caller = Proc.new { @called += 1 }

    instance_stub Book, :read, caller do
      person.read_book(Book.new)
    end

    assert_equal 1, @called
  end

  def test_basic_object_stubbing
    dog = Dog.new

    @called = 0
    caller = Proc.new { @called += 1 }
    stub dog, :name, caller do
      dog.name
    end

    assert_equal 1, @called
  end

  def test_module_stubbing
    @called = 0
    caller = Proc.new { @called += 1 }
    stub Project, :name, caller do
      Project.name
    end

    assert_equal 1, @called
  end
end
