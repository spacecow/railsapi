class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery #with: :null_session,
    #only: Proc.new { |c| c.request.format.json? }

  rescue_from(ActiveRecord::StatementInvalid){|e| record_invalid e}
  rescue_from(ActiveRecord::RecordNotUnique){|e| record_not_unique e}
  rescue_from ActionController::ParameterMissing, with: :record_missing
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
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

  def record_missing
    #Strong parameter's require is not fullfilled.
    render json:{
      error:'record in question is missing',
      class:ActionController::ParameterMissing.to_s}
  end

  def record_not_found
    #Trying to querry the database for a record with find(), but
    #the record is not there.
    render json:{
      error:'record in question is not found',
      class:ActiveRecord::RecordNotFound.to_s}
  end

  def repo
    @repo ||= Repository.new
  end

end
