require "spec_helper"

require "active_model"

describe SimpleAssertions::AssertErrorsOn do
  include SimpleAssertions::AssertRaises
  include SimpleAssertions::AssertErrorsOn

  Person = Struct.new(:username, :email, :fullname) do
    extend ActiveModel::Naming
    include ActiveModel::Validations

    validates :username, presence: true
    validates :email, presence: true, format: { with: %r{\A.+?@.*\z}, allow_blank: true }
    validates :fullname, presence: true, format: /\A\S+ \S+\z/

    def persisted?
      false
    end
  end

  describe "setup" do
    it "factories" do
      assert valid.valid?
      refute empty.valid?
    end
  end

  describe "basic" do
    it "validate record" do
      assert_assertion(/should be invalid/) do
        assert_errors_on valid
      end
    end

    it "yield block" do
      assert_assertion "inside" do
        assert_errors_on empty do
          flunk "inside"
        end
      end
    end
  end

  describe "error count with fixnum" do
    it "correct" do
      assert_errors_on empty, username: 1, email: 1
      assert_errors_on empty, username: 1
      assert_errors_on empty, [:username, :email] => 1
      assert_errors_on valid, username: 0, email: 0, fullname: 0 do
        assert valid.valid?
      end
    end

    it "implicit count is 1" do
      assert_errors_on empty, :username, :email
    end

    it "does not overwrite with implicit count" do
      assert_errors_on empty, :fullname, fullname: 2
    end

    it "fail" do
      assert_assertion(/2 error\(s\) expected for .*?\.username/) do
        assert_errors_on empty, username: 2
      end
    end
  end

  describe "partial match with regexp" do
    it "match" do
      assert_errors_on empty, username: /blank/, email: /blank/
      assert_errors_on person(username: nil, email: "invalid"), username: /blank/, email: /invalid/
      assert_errors_on empty, username: /blank/
      assert_errors_on empty, [:username, :email] => /blank/
    end

    it "mismatch" do
      assert_assertion(/expected to match.*?invalid.*?\.username/) do
        assert_errors_on empty, username: /invalid/
      end
    end

    it "raises for valid attributes" do
      person = person(username: nil, email: nil, fullname: "valid fullname")
      assert_assertion(/expected to match.*?WHY.*?\.fullname/) do
        assert_errors_on person, fullname: /WHY/
      end
    end
  end

  describe "exact single string match" do
    it "match" do
      assert_errors_on empty, username: "can't be blank", email: "can't be blank"
      assert_errors_on person(username: nil, email: "invalid"), username: "can't be blank", email: "is invalid"
      assert_errors_on empty, [:username, :email] => "can't be blank"
    end

    it "mismatch" do
      assert_assertion(/"is invalid" expected for.*?\.username/) do
        assert_errors_on empty, username: "is invalid"
      end
    end
  end

  describe "exact string match with array" do
    it "match" do
      assert_errors_on person(fullname: nil), fullname: ["can't be blank", "is invalid"]
      assert_errors_on person(fullname: nil), fullname: ["is invalid", "can't be blank"]
    end

    it "mismatch" do
      assert_assertion(/\["yay"\] expected for.*?\.fullname/) do
        assert_errors_on person(fullname: nil), fullname: ["yay"]
      end
    end
  end

  describe "translation match with symbol" do
    it "match" do
      assert_errors_on empty, username: :"errors.messages.blank"
    end

    it "mismatch" do
      assert_assertion(/:"errors\.messages\.invalid\"\(is invalid\) expected for.*?\.username/) do
        assert_errors_on empty, username: :"errors.messages.invalid"
      end
    end
  end

  describe "unknown matcher type" do
    it "fails" do
      assert_assertion("unknown matcher type Float: 1.0") do
        assert_errors_on empty, username: 1.0
      end
    end
  end

  private

  def assert_assertion(msg, &block)
    assert_raises(MiniTest::Assertion, message: msg, &block)
  end

  def empty
    person(username: nil, email: nil, fullname: nil)
  end

  def valid
    person
  end

  def person(attributes = {})
    attributes = { username: "foo", email: "foo@bar.com", fullname: "Foo Bar" }.merge(attributes)
    Person.new(*attributes.values_at(:username, :email, :fullname))
  end
end
