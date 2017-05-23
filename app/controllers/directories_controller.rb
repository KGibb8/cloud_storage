class DirectoriesController < ApplicationController

  def index
    @root = Directory.find_by(directory_id: nil)
  end

  def create

  end

end
