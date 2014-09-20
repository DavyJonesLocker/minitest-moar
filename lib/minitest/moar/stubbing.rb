module Minitest::Moar::Stubbing
  def stub klass, name, val_or_callable = nil, *block_args, &block
    @invocations ||= Hash.new { |h, k| h[k] = Hash.new { |_h, _k| _h[_k] = 0 } }

    new_name = "__minitest_stub__#{name}"

    metaclass = class << klass; self; end
    instance_stub metaclass, name, val_or_callable, block_args, &block
  end

  def instance_stub klass, name, val_or_callable = nil, *block_args, &block
    @invocations ||= Hash.new { |h, k| h[k] = Hash.new { |_h, _k| _h[_k] = 0 } }

    invoker = Proc.new { |klass, name| @invocations[klass][name] += 1 }

    new_name = "__minitest_stub__#{name}"

    if respond_to? name and not methods.map(&:to_s).include? name.to_s then
      klass.send :define_method, name do |*args|
        super(*args)
      end
    end

    klass.send :alias_method, new_name, name

    klass.send :define_method, name do |*args, &blk|
      if self.is_a?(Class)
        invoker.call(self, name)
      else
        invoker.call("Instance of #{self.class}", name)
      end

      ret = if val_or_callable.respond_to? :call then
        val_or_callable.call(*args)
      else
        val_or_callable
      end

      blk.call(*block_args) if blk

      ret
    end

    yield klass
  ensure
    klass.send :undef_method, name
    klass.send :alias_method, name, new_name
    klass.send :undef_method, new_name
  end
end

if Object.respond_to?(:stub)
  Object.send(:remove_method, :stub)
end
