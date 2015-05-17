class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery #with: :null_session,
    #only: Proc.new { |c| c.request.format.json? }

  rescue_from ActiveRecord::StatementInvalid, with: :record_invalid
  rescue_from ActionController::ParameterMissing, with: :record_missing

  def record_invalid
    render json:{error:'record in question is invalid'}
  end

  def record_missing
    render json:{error:'record in question is missing'}
  end

  def repo
    @repo ||= Repository.new
  end

end
