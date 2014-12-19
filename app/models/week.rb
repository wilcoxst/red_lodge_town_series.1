class Week < ActiveRecord::Base
  has_many :time_entries

  def self.get_week_names
    Week.all.sort_by { |week| week.name}.map { |week| week.name}
  end

end
