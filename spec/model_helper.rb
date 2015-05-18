require 'factory_girl'
require './spec/factories'
require 'active_record'
require './config/database'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
