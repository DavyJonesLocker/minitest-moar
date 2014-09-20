require "minitest/moar/version"

module Minitest
  module Moar
  end
end

require 'minitest/moar/stubbing'
require 'minitest/moar/assertions'

Minitest::Test.send(:include, Minitest::Moar::Stubbing)
Minitest::Test.send(:include, Minitest::Moar::Assertions)
