# Simple assertions [<img src="https://secure.travis-ci.org/neopoly/simple_assertions.png?branch=master" alt="Build Status" />](http://travis-ci.org/neopoly/simple_assertions)

A collection of usefull assertions.

[Gem](https://rubygems.org/gems/simple_assertions) |
[Source](https://github.com/neopoly/simple_assertions) |
[Documentation](http://rubydoc.info/github/neopoly/simple_assertions/master/fi
le/README.rdoc)

## Usage

```ruby
require 'simple_assertions'

class MiniTest::TestCase
  # include *SimpleAssertions.all
  include SimpleAssertions::AssertErrorsOn
  include SimpleAssertions::AssertRaises
end
```

## Assertions

* SimpleAssertions::AssertErrorsOn
* SimpleAssertions::AssertRaises

## Only >= 1.9.2 suported!

Note that only ruby version >= 1.9.2 is supported.

## Contributing

1. [Fork it](https://github.com/neopoly/simple_assertions/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
