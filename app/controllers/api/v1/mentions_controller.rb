module Api
  module V1
    class MentionsController < ApplicationController

      def create
        mention = repo.create_mention(
          origin_id:remove_origin_id,
          params: mention_params)
        render json:{mention:mention.full_json}
      end

      private

        def remove_origin_id
          params.require(:mention).delete(:origin_id)
        end

        def mention_params
          params.require(:mention).permit(:target_id)
        end

    end
  end
end
