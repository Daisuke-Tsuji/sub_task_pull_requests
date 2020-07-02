class AddColumnProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :website,       :string ,null: true, default: ""
    add_column :users, :introduction,  :string ,null: true, default: ""
    add_column :users, :phone,         :string ,null: true, default: ""
    add_column :users, :gender,        :string ,null: false, default: "0"
    #性別 0 => 選択なし 1 => 男性 , 2 => 女性 , 9 => その他
  end
end
