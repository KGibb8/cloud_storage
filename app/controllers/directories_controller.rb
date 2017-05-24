class DirectoriesController < ApplicationController
  before_action :find_root_directory, only: [:index]

  def index
  end

  def create
    directory = Directory.create(directory_params)
  end

  private

  def directory_params
    params.require(:directory).permit(:directory_id) || {}
  end

  def find_root_directory
    @root = Directory.find_by(directory_id: nil)
  end

end
