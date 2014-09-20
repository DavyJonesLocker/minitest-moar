# Minitest Moar #

[![Build Status](https://secure.travis-ci.org/dockyard/minitest-moar.png?branch=master)](http://travis-ci.org/dockyard/minitest-moar)
[![Dependency Status](https://gemnasium.com/dockyard/minitest-moar.png?travis)](https://gemnasium.com/dockyard/minitest-moar)
[![Code Climate](https://codeclimate.com/github/dockyard/minitest-moar.png)](https://codeclimate.com/github/dockyard/minitest-moar)

![Moar!](http://i.imgur.com/HfsSZV3.gif)

Some changes to Minitest and additional features

## Looking for help? ##

If it is a bug [please open an issue on
GitHub](https://github.com/dockyard/minitest-moar/issues).

## About

### Stub

By default Minitest pollutes `Object` with `Object#stub`. This gem
removes `Object#stub` and relaces with a method that is intended to be
used:

```ruby
stub Book, :read, true do
  # do your thing
end
```

No moar object pollution!

### Instance stubbing

Minitest doesn't come with any way to stub the instance of a class.
Minitest Moar does:

```ruby
instance_stub Person, :say, "hello" do
  person = Person.new

  # this is the stubbed method
  person.say
end
```

### Test Spies

**Note that test spies only work on stubbed methods.**

A common pattern might be to confirm if an object calls a method. You
can current do this with stubbing:

```ruby
@called = 0
caller = Proc.new { @called += 1 }
stub Book, :read, caller do
  Book.read
end
assert_equal 1, @called
```

With Minitest Moar you get test spies in the form of `assert_called`:

```ruby
stub Book, :read do
  Book.read
end
assert_called Book, :read
```

You can assert the number of invocations with the optional 3rd argument

```ruby
stub Book, :read do
  Book.read
  Book.read
end
assert_called Book, :read, 2
```

You can refute

```ruby
stub Book, :read do
  person = Person.new
  person.say
end
refute_called Book, :read
```

And you can refute the number of invocations:

```ruby
stub Book, :read do
  Book.read
end
refute_called Book, :read, 2
```

### Spying on instances

If you don't have access to the instance of the object in your test you
can spy on the instance of a class with `assert_instance_called` and
`refute_instance_called`

```ruby
instance_stub Person, :say, "hello" do
  person = Person.new
  person.say
end

assert_instance_called Person, :say
```

```ruby
instance_stub Person, :say, "hello" do
  Book.read
end

refute_instance_called Person, :say
```

## Authors ##

* [Brian Cardarella](http://twitter.com/bcardarella)

[We are very thankful for the many contributors](https://github.com/dockyard/minitest-moar/graphs/contributors)

## Versioning ##

This gem follows [Semantic Versioning](http://semver.org)

## Want to help? ##

Please do! We are always looking to improve this gem. Please see our
[Contribution Guidelines](https://github.com/dockyard/minitest-moar/blob/master/CONTRIBUTING.md)
on how to properly submit issues and pull requests.

## Legal ##

[DockYard](http://dockyard.com), Inc. &copy; 2014

[@dockyard](http://twitter.com/dockyard)

[Licensed under the MIT license](http://www.opensource.org/licenses/mit-license.php)
