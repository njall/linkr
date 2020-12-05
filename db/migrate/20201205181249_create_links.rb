class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :slug
      t.string :url
      t.integer :counter
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
