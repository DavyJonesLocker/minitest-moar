module Minitest::Moar::Stubbing
  def stub klass, name, val_or_callable = nil, *block_args, &block
    @invocations ||= Hash.new { |h, k| h[k] = Hash.new { |_h, _k| _h[_k] = 0 } }

    metaclass = class << klass; self; end

    if metaclass.respond_to? name and not metaclass.instance_methods.map(&:to_s).include? name.to_s then
      metaclass.send :define_method, name do |*args|
        super(*args)
      end
    end
    __stub__ metaclass, name, val_or_callable, block_args, &block
  end

  def instance_stub obj, name, val_or_callable = nil, *block_args, &block
    if obj.respond_to? name and not obj.methods.map(&:to_s).include? name.to_s then
      obj.send :define_method, name do |*args|
        super(*args)
      end
    end

    __stub__ obj, name, val_or_callable, block_args, &block
  end

  def __stub__ obj, name, val_or_callable = nil, *block_args, &block
    new_name = "__minitest_stub__#{name}"

    @invocations ||= Hash.new { |h, k| h[k] = Hash.new { |_h, _k| _h[_k] = 0 } }

    invoker = Proc.new { |k, n| @invocations[k][n] += 1 }

    obj.send :alias_method, new_name, name

    # Module.method(:define_method).bind(klass).call(name) do |*args, &blk|
    obj.send :define_method, name do |*args, &blk|
      if ::Class === self
        invoker.call(self, name)
      else
        klass = Kernel.instance_method(:class).bind(self).call
        invoker.call("Instance of #{klass}", name)
      end

      ret = if val_or_callable.respond_to? :call then
        val_or_callable.call(*args)
      else
        val_or_callable
      end

      blk.call(*block_args) if blk

      ret
    end

    yield obj
  ensure
    obj.send :undef_method, name
    obj.send :alias_method, name, new_name
    obj.send :undef_method, new_name
  end
end

if Object.respond_to?(:stub)
  Object.send(:remove_method, :stub)
end
