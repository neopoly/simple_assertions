require 'helper'

require 'active_model'

class SimpleAssertionsAssertErrorsOnTest < Spec
  include SimpleAssertions::AssertRaises
  include SimpleAssertions::AssertErrorsOn

  Person = Struct.new(:username, :email, :fullname) do
    extend ActiveModel::Naming
    include ActiveModel::Validations

    validates :username, :presence => true
    validates :email, :presence => true, :format => { :with => %r{^\A.+?@.*\Z}, :allow_blank => true }
    validates :fullname, :presence => true, :format => /\A\S+ \S+\Z/

    def persisted?
      false
    end
  end

  context "setup" do
    test "factories" do
      assert valid.valid?
      refute empty.valid?
    end
  end

  context "basic" do
    test "validate record" do
      assert_assertion /should be invalid/ do
        assert_errors_on valid
      end
    end

    test "yield block" do
      assert_raises RuntimeError, :message => /inside/ do
        assert_errors_on empty do
          fail "inside"
        end
      end
    end
  end

  context "error count with fixnum" do
    test "correct" do
      assert_errors_on empty, :username => 1, :email => 1
      assert_errors_on empty, :username => 1
      assert_errors_on empty, [ :username, :email ] => 1
      assert_errors_on valid, :username => 0, :email => 0, :fullname => 0 do
        assert valid.valid?
      end
    end

    test "implicit count is 1" do
      assert_errors_on empty, :username, :email
    end

    test "does not overwrite with implicit count" do
      assert_errors_on empty, :fullname, :fullname => 2
    end

    test "fail" do
      assert_assertion /2 error\(s\) expected for .*?\.username/ do
        assert_errors_on empty, :username => 2
      end
    end
  end

  context "partial match with regexp" do
    test "match" do
      assert_errors_on empty, :username => /blank/, :email => /blank/
      assert_errors_on person(:username => nil, :email => "invalid"), :username => /blank/, :email => /invalid/
      assert_errors_on empty, :username => /blank/
      assert_errors_on empty, [ :username, :email ] => /blank/
    end

    test "mismatch" do
      assert_assertion /expected to match.*?invalid.*?\.username/ do
        assert_errors_on empty, :username => /invalid/
      end
    end
  end

  context "exact single string match" do
    test "match" do
      assert_errors_on empty, :username => "can't be blank", :email => "can't be blank"
      assert_errors_on person(:username => nil, :email => "invalid"), :username => "can't be blank", :email => "is invalid"
      assert_errors_on empty, [ :username, :email ] => "can't be blank"
    end

    test "mismatch" do
      assert_assertion /"is invalid" expected for.*?\.username/ do
        assert_errors_on empty, :username => "is invalid"
      end
    end
  end

  context "exact string match with array" do
    test "match" do
      assert_errors_on person(:fullname => nil), :fullname => ["can't be blank", "is invalid"]
      assert_errors_on person(:fullname => nil), :fullname => ["is invalid", "can't be blank"]
    end

    test "mismatch" do
      assert_assertion /\["yay"\] expected for.*?\.fullname/ do
        assert_errors_on person(:fullname => nil), :fullname => ["yay"]
      end
    end
  end

  private

  def assert_assertion(msg, &block)
    assert_raises(MiniTest::Assertion, :message => msg, &block)
  end

  def empty
    person(:username => nil, :email => nil, :fullname => nil)
  end

  def valid
    person
  end

  def person(attributes={})
    attributes = { :username => "foo", :email => "foo@bar.com", :fullname => "Foo Bar" }.merge(attributes)
    Person.new(*attributes.values_at(:username, :email, :fullname))
  end
end
