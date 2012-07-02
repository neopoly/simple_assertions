module SimpleAssertions
  # Adds attribute matcher to +assert_raises+.
  #
  # == Example
  #
  #   # old behaviour
  #   assert_raises(StandardError) { ... }
  #
  #   # exact match on attribute message
  #   assert_raises(RuntimeError, :message => "yay!") do
  #     raise "yay!"
  #   end
  #
  #   # pattern match on attributes
  #   assert_raises(MyError, :message => /foo/, :code => 23) do
  #     raise MyError, "foo bar", 23
  #   end
  module AssertRaises
    def assert_raises(*args, &block)
      attributes = args.last.is_a?(Hash) ? args.pop : {}
      exception = super(*args, &block).tap do |exception|
        attributes.each do |attribute, expected|
          assert_respond_to exception, attribute
          actual = exception.public_send(attribute)
          msg = "Expected #{mu_pp(expected)} to match #{mu_pp(actual)} for #{attribute} on #{mu_pp(exception)}"
          matched = expected == actual || expected === actual
          assert matched, msg
        end
      end
    end
  end
end
