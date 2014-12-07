class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.decimal :timing
      t.integer :run
      t.references :week, index: true
      t.references :racer, index: true

      t.timestamps
    end
  end
end
