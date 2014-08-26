class AddYearToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :year, :integer
  end
end
