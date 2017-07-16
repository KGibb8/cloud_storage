class DirectoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_root_directory, only: [:index]
  before_action :find_directory, only: [:show]

  # TODO: Rethink User/Account idea
  def index
  end

  def create
    directory = Directory.create(directory_params)
  end

  def show
    respond_to do |format|
      format.js do
        render 'directory'
      end
    end
  end

  private

  def directory_params
    params.require(:directory).permit(:directory_id)
  end

  def find_root_directory
    @root = current_account ? params[:id] ? Directory.find(params[:id]) : Directory.find_by(directory_id: nil) : current_user.root
  end

  def find_directory
    @directory = Directory.find(params[:id])
  end

end
