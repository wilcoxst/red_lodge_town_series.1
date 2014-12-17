class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :name
      t.date :date
      t.timestamps
    end
  end
end
