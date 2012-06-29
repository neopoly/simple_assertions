module SimpleAssertions
  autoload :AssertErrorsOn, 'simple_assertions/assert_errors_on'
  autoload :AssertRaises,   'simple_assertions/assert_raises'

  autoload :VERSION,        'simple_assertions/version'

  def self.all
    mods = constants - [ :VERSION ]
    mods.map { |mod| const_get(mod) }
  end
end
