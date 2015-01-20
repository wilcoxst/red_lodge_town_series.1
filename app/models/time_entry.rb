require 'csv'

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


  def self.import_csv(file)

    # Entries will be applied to latest week
    week_id = Week.get_max_week_id
    puts 'last week id is ' + week_id.to_s

    # We only care about which racer, and the 2 run times
    data = file.read
    CSV.parse(data, headers:true) do |row|
      if row['Id'] != nil and row['Run1'] != nil and row['Run2'] != nil
        time_entry = TimeEntry.new
        time_entry.week_id = week_id
        puts 'row[:id] is ' + row['Id']
        puts 'row[:id].to_i is ' + row['Id'].to_i.to_s
        time_entry.racer_id = row['Id'].to_i
        time_entry.run1 = row['Run1'].to_f
        time_entry.run2 = row['Run2'].to_f
        time_entry.save
      else
        puts 'empty row in csv'
      end
    end
  end


end
