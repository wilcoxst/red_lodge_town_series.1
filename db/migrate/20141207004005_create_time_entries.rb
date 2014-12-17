class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.decimal :run1
      t.decimal :run2
      t.references :week, index: true
      t.references :racer, index: true
      t.timestamps
    end
    add_index :time_entries, [:week_id, :racer_id], :unique => true
  end
end
