class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string     :title,       null: false
      t.string     :images 
      t.integer    :category_id, null: false
      t.integer    :part_id
      t.integer    :skin_id
      t.text       :detail,      null: false
      t.references :user,        null: false, foreign_key: true
      t.timestamps
    end
  end
end
