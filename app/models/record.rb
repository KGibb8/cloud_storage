class Record < ApplicationRecord
  belongs_to :directory
  belongs_to :user

  before_validation :search_for_owner

  validates_presence_of :user, :directory

  private

  def search_for_owner
    until user.present?
      set_owner(directory)
    end
  end

  def set_owner(host_directory)
    self.user = host_directory.user
  end
end
