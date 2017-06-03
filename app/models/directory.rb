class Directory < ApplicationRecord
  belongs_to :user, required: false

  belongs_to :parent, class_name: 'Directory', foreign_key: :directory_id, inverse_of: :children, required: false
  has_many :children, class_name: 'Directory', foreign_key: :directory_id, inverse_of: :parent, dependent: :destroy

  has_many :records, dependent: :destroy

  scope :user, ->(user_id) { where(user_id: user_id) }

  before_validation :search_for_owner

  # validates_presence_of :user

  validate :singularity_of_root

  def tree
    ActiveRecord::Base.transaction { recurse }
  end

  def recurse
    tree_node.tap do |node|
      unless children.empty?
        children.each do |child|
          node['children'] << child.recurse
        end
      end
    end
  end

  private

  def tree_node
    attributes.merge('records' => records_attributes, 'children' => [])
  end

  def records_attributes
    records.inject([]) do |array, record|
      array << record.attributes.merge(record_url: record.path_to_file)
    end
  end

  # ##############
  # # Validation #
  # ##############

  def singularity_of_root
    if user
      self.errors.add(:singularity_of_root, 'Already has a root directory') if user.directories.count > 1 && directory_id.nil?
    else
      self.errors.add(:singularity_of_root, 'Already has a root directory') if Directory.count > 1 && directory_id.nil?
    end
  end

  # #########
  # # Hooks #
  # #########

  # %%TODO%% Currently sets owned based on parent folder struture.
  # This will change if users take ownership of account directories.
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
