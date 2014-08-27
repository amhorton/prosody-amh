class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.integer :start
      t.integer :end
      t.integer :article_id
      t.integer :user_id
      t.string :text

      t.timestamps
    end
  end
end
