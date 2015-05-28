class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery #with: :null_session,
    #only: Proc.new { |c| c.request.format.json? }

  rescue_from(ActiveRecord::StatementInvalid){|e| record_invalid e}
  rescue_from(ActiveRecord::RecordNotUnique){|e| record_not_unique e}
  rescue_from(ActionController::ParameterMissing){|e| nested_parameter_missing e}
  rescue_from(ActiveRecord::RecordNotFound){|e| record_not_found e}
  rescue_from(ActiveRecord::SubclassNotFound){|e| subclass_not_found e}

  def subclass_not_found error
    column, table = "", ""
    if match = error.message.match(/is not a subclass of (.*)$/)
      column = 'type'
      table = match.captures.first
      msg = 'is invalid'
    end
    render status: :bad_request,
           json:{table.downcase.to_sym => {column.to_sym => msg}}
  end

  def record_not_unique error
    column, table = "", ""
    if match = error.message.match(/duplicate key.*_on_(.*?)".*INSERT INTO "(.*?)"/m)
      column, table = match.captures
      msg = 'is already taken'
    end
    render status: :bad_request,
           json:{table.singularize.to_sym => {column.to_sym => msg}}
  end

  def record_invalid error
    column, table = "", ""
    if match = error.message.match(/null value in column "(.*?)".*INSERT INTO "(.*?)"/m)
      column, table = match.captures
      msg = 'cannot be null'
    elsif match = error.message.match(/check constraint "(.*?)_cannot_be_blank.*INSERT INTO "(.*?)"/m)
      column, table = match.captures
      msg = 'cannot be blank'
    end
    render status: :bad_request,
           json:{table.singularize.to_sym => {column.to_sym => msg}}
  end

  def nested_parameter_missing error
    column = ""
    if match = error.message.match(/param is missing or the value is empty: (.*)/) 
      column = match.captures.first
      msg = 'is missing'
    end
    render status: :bad_request,
           json:{column.to_sym => msg}
  end

  def record_not_found error
    if match = error.message.match(/Couldn't find (.*) with '(.*)'/)
      table, column = match.captures
      msg = 'is not found'
    end
    render status: :bad_request,
           json:{table.downcase.to_sym => {column.to_sym => msg}}
  end

  def repo
    @repo ||= Repository.new
  end

end
