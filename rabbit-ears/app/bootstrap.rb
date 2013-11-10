# there are a million useful things in active_support,
# in particular cache and notifications... but we dont
# assume you want them.
require File.expand_path('app/environment_key')
require 'active_support/time'
require 'active_support/inflector'
require 'active_support/core_ext'


# load environment-dependent config.
Global.environment = ENV[ENVIRONMENT_KEY] || "development"
Global.config_directory = "config"

# require our environment-specific stuff.
require File.expand_path(File.join('config',
                                   'environments',
                                   "#{Global.environment}.rb"))

# require the initializers.
require_all File.expand_path('config/initializers')


require_all File.expand_path('app/models')
require_all File.expand_path('app/parsers')
require_all File.expand_path('app/reporters')
# require_all File.expand_path('app/mailers')