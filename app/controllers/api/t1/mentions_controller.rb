module Api
  module T1
    class MentionsController < ApplicationController

      def create
        mention = factory.create_mention mention_params 
        render json:{mention:mention.factory_json}
      end

      def delete_all
        mentions = factory.delete_mentions
        render json:{mentions:mentions.map(&:factory_json)}
      end

      private

        def mention_params
          (params[:mention] || ActionController::Parameters.new()).
            permit(:origin_id, :target_id)
        end

    end
  end
end
