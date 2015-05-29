module ActiveRecord
  class RecordNotUnique; end
  class StatementInvalid; end
  class RecordNotFound; end
  class SubclassNotFound; end
end unless defined?(ActiveRecord)

module ActionController
  class Base
    def self.protect_from_forgery *args; end
    def self.rescue_from *args; end
  end
  class ParameterMissing; end
end unless defined?(ActionController)

class Rails
  def self.env
    Struct.new(:test?).new(true)
  end
end unless defined?(Rails)

require './app/controllers/application_controller'
