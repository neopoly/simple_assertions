module SimpleAssertions
  module AssertErrorsOn
    # http://gist.github.com/49013
    #
    # Assert errors on given parameters.
    # It call #valid? on +object+ unless called with a block.
    #
    # assert_errors_on record, :email
    # assert_errors_on record, :email => 2
    # assert_errors_on record, :email => "is blank"
    # assert_errors_on record, :email => /blank/
    # assert_errors_on record, :email => ["is blank", "is invalid"]
    # assert_errors_on record, :email, :plz => 2
    # assert_errors_on record, [:username, :email] => "is blank"
    #
    # assert_errors_on record, :email => 1 do
    #   assert record.save
    # end
    def assert_errors_on(object, *attributes_or_hash)
      if block_given?
        yield
      else
        assert !object.valid?, "#{object.inspect} should be invalid."
      end

      hash = attributes_or_hash[-1].is_a?(Hash) ? attributes_or_hash.pop : {}
      attributes_or_hash.each { |field| hash[field] = 1 }

      hash.each do |fields, pattern|
        Array.wrap(fields).each do |field|
          errors = Array.wrap(object.errors[field])

          case pattern
          when Fixnum
            assert_equal pattern, errors.size,
              "#{pattern} error(s) expected for #{object.class}.#{field} but got #{errors.inspect}."
          when Regexp
            assert errors.all? { |message| pattern.match(message) },
              "expected to match #{pattern} for #{object.class}.#{field} but got #{errors.inspect}."
          when String
            assert_equal [ pattern ], errors,
              "#{pattern.inspect} error(s) expected for #{object.class}.#{field} but got #{errors.inspect}."
          when Array
            assert_equal pattern.sort, errors.sort,
              "#{pattern.inspect} error(s) expected for #{object.class}.#{field} but got #{errors.inspect}."
          else
            fail "unknown type #{pattern.inspect}"
          end
        end
      end
    end
  end
end
