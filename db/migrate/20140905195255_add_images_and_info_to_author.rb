class AddImagesAndInfoToAuthor < ActiveRecord::Migration
  def self.up
    change_table :authors do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :authors, :image
  end

  def change
    add_column :authors, :info, :string
  end
end
