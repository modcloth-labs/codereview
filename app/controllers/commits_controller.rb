class CommitsController < ApplicationController
  def index
    Commit.sync
    @commits = Commit.get_list
  end


end
