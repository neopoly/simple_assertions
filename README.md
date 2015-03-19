[github]: https://github.com/neopoly/simple_assertions
[doc]: http://rubydoc.info/github/neopoly/simple_assertions/master/file/README.md
[gem]: https://rubygems.org/gems/simple_assertions
[gem-badge]: https://img.shields.io/gem/v/simple_assertions.svg
[travis]: https://travis-ci.org/neopoly/simple_assertions
[travis-badge]: https://img.shields.io/travis/neopoly/simple_assertions.svg?branch=master
[codeclimate]: https://codeclimate.com/github/neopoly/simple_assertions
[codeclimate-climate-badge]: https://img.shields.io/codeclimate/github/neopoly/simple_assertions.svg
[codeclimate-coverage-badge]: https://codeclimate.com/github/neopoly/simple_assertions/badges/coverage.svg
[inchpages]: https://inch-ci.org/github/neopoly/simple_assertions
[inchpages-badge]: https://inch-ci.org/github/neopoly/simple_assertions.svg?branch=master&style=flat

# Simple assertions

[![Travis][travis-badge]][travis]
[![Gem Version][gem-badge]][gem]
[![Code Climate][codeclimate-climate-badge]][codeclimate]
[![Test Coverage][codeclimate-coverage-badge]][codeclimate]
[![Inline docs][inchpages-badge]][inchpages]

[Gem][gem] |
[Source][github] |
[Documentation][doc]

A collection of useful assertions.

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

## Only >= 2.0 suported!

Note that only ruby version >= 2.0 is supported.

## Contributing

1. [Fork it](https://github.com/neopoly/simple_assertions/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
