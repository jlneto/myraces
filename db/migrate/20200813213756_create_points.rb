class CreatePoints < ActiveRecord::Migration[6.0]
  def change
    create_table :points do |t|
      t.string :name
      t.string :tags
      t.string :coordinates
      t.string :decription
      t.belongs_to :strategy, null: false, foreign_key: true
      t.string :type
      t.integer :likes
      t.integer :dislikes

      t.timestamps
    end
  end
end
