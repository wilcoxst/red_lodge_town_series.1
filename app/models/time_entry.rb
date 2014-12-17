class TimeEntry < ActiveRecord::Base
  belongs_to :week
  belongs_to :racer


  def self.getSet(gender, discipline, classification, week)
    set = TimeEntry.joins(:racer).where({racers: {gender: gender, discipline_id: discipline.id, classification_id: classification.id}, time_entries: {week_id: week.id}}).sort_by { |time_entry| time_entry.combined }
    i = 0
    while i < set.size
      time_entry = set[i]
      time_entry.set_points i+1

      # handle ties (if times of previous skier are the same, give this racer the same number of points)
      if (i > 0)
        previous_time_entry = set[i-1]
        if time_entry.combined == previous_time_entry.combined
          time_entry.set_points(previous_time_entry.get_points)
        end
      end
      #puts time_entry.racer.name + ' combined: ' + time_entry.combined.to_s + ' points: ' + time_entry.get_points.to_s
      i+=1
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

end
