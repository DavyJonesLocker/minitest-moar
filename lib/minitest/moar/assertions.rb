module Minitest::Moar::Assertions
  def assert_called object, method, count = nil
    invoked = get_invocation_count(object, method)

    if count.nil?
      assert invoked > 0, "#{object} expected to call #{method} but did not."
    else
      assert_equal count, invoked, "#{object} expected to call #{method} #{count} times but it was only called #{invoked} times."
    end
  end

  def assert_instance_called object, method, count = nil
    assert_called "Instance of #{object}", method, count
  end

  def refute_called object, method, count = nil
    invoked = get_invocation_count(object, method)

    if count.nil?
      refute invoked > 0, "#{object} expected to not call #{method} but did."
    else
      refute_equal count, invoked, "#{object} expected to not call #{method} #{count} times but it did."
    end
  end

  def refute_instance_called object, method, count = nil
    refute_called "Instance of #{object}", method, count
  end

  private

  def get_invocation_count(object, method)
    if @invocations
      @invocations[object][method]
    else
      0
    end
  end
end
