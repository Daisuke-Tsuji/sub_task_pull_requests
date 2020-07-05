class AddColumnProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :website,       :string ,null: true, default: ""
    add_column :users, :introduction,  :string ,null: true, default: ""
    add_column :users, :phone,         :string ,null: true, default: ""
    add_column :users, :gender,        :string ,null: false, default: "0"
  end
end
