module Repo
  module UniverseRepository

    def universe id; Universe.find id end
    def universes; Universe.all end
    def create_universe params; Universe.create params end
    def delete_universes; Universe.destroy_all end

  end
end
