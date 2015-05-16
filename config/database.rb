require 'yaml'

ENV['RACK_ENV'] = "test"
databases = YAML.load_file "config/database.yml"
ActiveRecord::Base.establish_connection databases[ENV['RACK_ENV']]
