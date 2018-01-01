class AddDisciplineAbbreviation < ActiveRecord::Migration
  def change
      add_column :disciplines, :abbreviation, :string
  end
end
