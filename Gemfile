source 'https://rubygems.org'

puppetversion = ENV['PUPPET_VERSION']

is_ruby18 = RUBY_VERSION.start_with? '1.8'

if is_ruby18
  gem 'rspec', "~> 3.1.0",   :require => false
end
gem 'puppet', puppetversion, :require => false
gem 'puppet-lint'
gem 'puppetlabs_spec_helper', '>= 0.1.0'
gem 'rspec-puppet'
gem 'metadata-json-lint'

group :development do
  gem 'puppet-blacksmith'
end

# puppet lint plugins
# https://puppet.community/plugins/#puppet-lint
gem 'puppet-lint-appends-check',
    :git => 'https://github.com/voxpupuli/puppet-lint-appends-check.git',
    :require => false
gem 'puppet-lint-classes_and_types_beginning_with_digits-check',
    :git => 'https://github.com/voxpupuli/puppet-lint-classes_and_types_beginning_with_digits-check.git',
    :require => false
#gem 'puppet-lint-empty_string-check',
#    :git => 'https://github.com/voxpupuli/puppet-lint-empty_string-check.git',
#    :require => false
gem 'puppet-lint-file_ensure-check',
    :git => 'https://github.com/voxpupuli/puppet-lint-file_ensure-check.git',
    :require => false
gem 'puppet-lint-leading_zero-check',
    :git => 'https://github.com/voxpupuli/puppet-lint-leading_zero-check.git',
    :require => false
gem 'puppet-lint-numericvariable',
    :git => 'https://github.com/fiddyspence/puppetlint-numericvariable.git',
    :require => false
gem 'puppet-lint-resource_reference_syntax',
    :git => 'https://github.com/voxpupuli/puppet-lint-resource_reference_syntax.git',
    :require => false
gem 'puppet-lint-spaceship_operator_without_tag-check',
    :git => 'https://github.com/voxpupuli/puppet-lint-spaceship_operator_without_tag-check.git',
    :require => false
gem 'puppet-lint-trailing_comma-check',
    :git => 'https://github.com/voxpupuli/puppet-lint-trailing_comma-check.git',
    :require => false
gem 'puppet-lint-undef_in_function-check',
    :git => 'https://github.com/voxpupuli/puppet-lint-undef_in_function-check.git',
    :require => false
gem 'puppet-lint-unquoted_string-check',
    :git => 'https://github.com/voxpupuli/puppet-lint-unquoted_string-check.git',
    :require => false
gem 'puppet-lint-variable_contains_upcase',
    :git => 'https://github.com/fiddyspence/puppetlint-variablecase.git',
    :require => false
gem 'puppet-lint-version_comparison-check',
    :git => 'https://github.com/voxpupuli/puppet-lint-version_comparison-check.git',
    :require => false
