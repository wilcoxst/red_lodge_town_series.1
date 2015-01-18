class Week < ActiveRecord::Base
  has_many :time_entries

  validates :name, uniqueness: true

  def self.get_week_names
    Week.all.sort_by { |week| week.name}.map { |week| week.name}
  end

  def self.get_max_week_id
    get_week_names[-1]
  end

end
