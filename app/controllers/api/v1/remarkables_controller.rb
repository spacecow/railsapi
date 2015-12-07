module Api
  module V1
    class RemarkablesController < ApplicationController

      def delete_all  
        remarkables = repo.delete_remarkables
        render json:{remarkables:remarkables.map(&:full_json)}
      end

    end
  end
end
