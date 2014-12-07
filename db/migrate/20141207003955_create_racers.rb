class CreateRacers < ActiveRecord::Migration
  def change
    create_table :racers do |t|
      t.string :name
      t.string :gender
      t.references :team, index: true
      t.references :discipline, index: true
      t.references :classification, index: true

      t.timestamps
    end
  end
end
