class AddAttachmentPictureToRecipes < ActiveRecord::Migration[5.0]
  def self.up
    change_table :recipes do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :recipes, :picture
  end
end
