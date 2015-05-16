module ActiveRecord
  class StatementInvalid; end
end unless defined?(ActiveRecord)
module ActionController
  class Base
    def self.protect_from_forgery *args; end
    def self.rescue_from *args; end
  end
end unless defined?(ActionController)
require './app/controllers/application_controller'
