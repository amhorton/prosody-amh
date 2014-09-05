class ChangeInfoTypeInAuthors < ActiveRecord::Migration
  def change
    change_column :authors, :info, :text
  end
end
