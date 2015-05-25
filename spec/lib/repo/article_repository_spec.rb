require 'model_helper'
require './app/models/article'
require './app/models/universe'
require './lib/repo/article_repository'
require 'rspec/its'

class Dummy
  include Repo::ArticleRepository
end

describe Repo::ArticleRepository do

  let(:repository){ Dummy.new }

end
