class CreateLayouts < ActiveRecord::Migration[6.0]
  def change
    create_table :layouts do |t|
      t.string :name
      t.belongs_to :track, null: false, foreign_key: true
      t.string :difficulty

      t.timestamps
    end
  end
end
