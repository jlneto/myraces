class CreatePoints < ActiveRecord::Migration[6.0]
  def change
    create_table :points do |t|
      t.belongs_to :strategy, null: false, foreign_key: true
      t.string :coordinates
      t.string :description
      t.string :name
      t.string :tags
      t.timestamps
    end
  end
end
