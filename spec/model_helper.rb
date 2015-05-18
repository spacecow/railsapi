unless defined? FactoryGirl
  require 'factory_girl_rails'
  require './spec/factories'
end
require 'active_record'
require './config/database'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
