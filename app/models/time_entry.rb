class TimeEntry < ActiveRecord::Base
  belongs_to :week
  belongs_to :racer


  def self.getSet(gender, discipline, classification, week)
    set = TimeEntry.joins(:racer).where({racers: {gender: gender, discipline_id: discipline.id, classification_id: classification.id},
                                         time_entries: {week_id: week.id}}).sort_by { |time_entry| time_entry.combined }
    set.each_with_index do |time_entry, i|
      time_entry = set[i]
      time_entry.set_points i+1

      # handle ties (if times of previous skier are the same, give this racer the same number of points)
      if (i > 0)
        previous_time_entry = set[i-1]
        if time_entry.combined == previous_time_entry.combined
          time_entry.set_points(previous_time_entry.get_points)
        end
      end
    end
    set
  end

  def combined
    run1 + run2
  end

  def set_points(points)
    @points = points
  end

  def get_points
    @points
  end


  def exclude_from_team
    @excluded_from_team = true
  end

  def is_excluded_from_team?
    not @excluded_from_team.nil?
  end

end
