class UniversesController < ApplicationController

  def index
    universes = Universe.all
    respond_to do |f|
      f.json{ render json:universes }
    end
  end

end
