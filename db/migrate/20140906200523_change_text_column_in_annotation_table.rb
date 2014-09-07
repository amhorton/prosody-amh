class ChangeTextColumnInAnnotationTable < ActiveRecord::Migration
  def change
    change_column :annotations, :text, :text
  end
end
