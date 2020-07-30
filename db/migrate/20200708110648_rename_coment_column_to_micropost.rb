class RenameComentColumnToMicropost < ActiveRecord::Migration[6.0]
  def change
    rename_column :microposts, :coment, :comment
  end
end
