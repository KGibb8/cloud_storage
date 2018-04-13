class Record < ApplicationRecord
  belongs_to :directory
  belongs_to :user

  scope :user, ->(user_id) { where user_id: user_id }

  # before_validation :search_for_owner

  validates_presence_of :directory

  has_attached_file :attachment

  do_not_validate_attachment_file_type :attachment

  def path_to_file
    attachment.url
  end

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
