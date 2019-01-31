class CreateJwtBlackLists < ActiveRecord::Migration[5.0]
  def change
    create_table :jwt_black_lists do |t|
      t.string :jti, null: false
  end
    add_index :jwt_black_lists, :jti
  end
end
