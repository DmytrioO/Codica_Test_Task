class CreateConclusions < ActiveRecord::Migration[7.0]
  def change
    create_table :conclusions do |t|
      t.text :recommendations, null: false
      t.belongs_to :appointment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
