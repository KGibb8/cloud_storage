class AddAttachmentToRecord < ActiveRecord::Migration[5.0]
  def change
    add_attachment :records, :attachment
  end
end
