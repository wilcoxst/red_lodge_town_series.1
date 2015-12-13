class Week < ActiveRecord::Base
  has_many :time_entries

  validates :name, uniqueness: true

  def self.all_weeks_with_times
    Week.all.select{ |week| TimeEntry.find_by_week_id week.id}.sort_by { |week| week.name}
  end

  def self.get_week_names
    Week.all_weeks_with_times.map { |week| week.name}
  end

  def self.get_last_week
    Week.all_weeks_with_times[-1]
  end

  def self.get_max_week_id
    max_week = Week.all.sort_by { |week| week.name}[-1]
    max_week.id.to_s
  end

end
