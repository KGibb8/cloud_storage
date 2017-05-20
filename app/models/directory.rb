class Directory < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: 'Directory', foreign_key: :directory_id, inverse_of: :children, required: false

  has_many :children, class_name: 'Directory', foreign_key: :directory_id, inverse_of: :parent
  has_many :records

  before_validation :search_for_owner

  validates_presence_of :user

  validate :singularity_of_root

  def tree
    ActiveRecord::Base.transaction { recurse }
  end

  def recurse
    local_attrs = attributes
    local_attrs[:records] = records.inject([]) do |array, record|
      array << record.attributes
    end
    local_attrs[:children] = []
    unless children.empty?
      children.each do |child|
        local_attrs[:children] << child.recurse
      end
    end
    local_attrs
  end

  private

  def singularity_of_root
    self.errors.add(:singularity_of_root, 'This user already has a root directory') if user.root.present? && directory_id.nil?
  end

  def search_for_owner
    unless directory_id.nil?
      until user.present?
        set_owner(parent)
      end
    end
  end

  def set_owner(parent_directory)
    self.user = parent_directory.user
  end

end
