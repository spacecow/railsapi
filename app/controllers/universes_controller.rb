class UniversesController < ApplicationController

  def index
    universes = Universe.all
    respond_to do |f|
      f.json{ render json:universes }
    end
  end

  def create
    begin
      universe = Universe.create params.permit(:title)
      respond_to do |f|
        f.json{ render json:universe }
      end
    rescue ActiveRecord::StatementInvalid
      render json:{error:'yeah'}
    end
  end

end
