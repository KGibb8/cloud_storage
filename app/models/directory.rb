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
    tree_node.tap do |node|
      unless children.empty?
        children.each do |child|
          node[:children] << child.recurse
        end
      end
    end
  end

  private

  def tree_node
    attributes.merge(records: records_attributes, children: [])
  end

  def records_attributes
    records.inject([]) do |array, record|
      array << record.attributes
    end
  end

  # ##############
  # # Validation #
  # ##############

  def singularity_of_root
    self.errors.add(:singularity_of_root, 'This user already has a root directory') if user.root.present? && directory_id.nil?
  end

  # #########
  # # Hooks #
  # #########

  def search_for_owner
    unless directory_id.nil?
      current_directory = self
      until current_directory.directory_id.nil?
        current_directory = current_directory.parent
        break if current_directory.user.present?
      end
      self.user = current_directory.user
    end
  end

end
