class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :text
      t.integer :author_id
      t.integer :user_id

      t.timestamps
    end
    add_index :articles, :author_id
    add_index :articles, :user_id
  end
end
