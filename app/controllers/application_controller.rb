class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery #with: :null_session,
    #only: Proc.new { |c| c.request.format.json? }

  rescue_from ActiveRecord::StatementInvalid, with: :record_invalid
  rescue_from ActionController::ParameterMissing, with: :record_missing
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_invalid
    #Database integrity violated.
    render json:{
      error:'record in question is invalid',
      class:ActiveRecord::StatementInvalid.to_s}
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
      error:'record in question is missing',
      class:ActiveRecord::RecordNotFound.to_s}
  end

  def repo
    @repo ||= Repository.new
  end

end
