class ResultsController < ApplicationController
  #before_action :set_week, only: [:show, :edit, :update, :destroy]

  # GET /results
  # GET /results.json
  def index
    @racers = Racer.all
    @teams = Team.all
    @weeks = Week.all_weeks_with_times
    @time_entries = TimeEntry.all
  end

  def rankings
    calculate_points
    delete_blanks @results
  end

  def times
    calculate_points
    delete_blanks @results
  end

  def points
    calculate_points
    delete_blanks @results
  end

  def individual_times
    calculate_points
    only_individuals
    delete_blanks @results
  end

  def team_results
    calculate_team_points
    @teams = Team.all
  end

  def team_points
    calculate_team_points
    @last_week = Week.get_last_week
    @last_week_id = Week.get_max_week_id
    @teams = Team.all
  end

  def individual_results
    @last_week = Week.get_last_week
    @last_week_time_entries = TimeEntry.last_week_entries
  end



  private

  def calculate_points
    genders = %w(F M)

    # results[gender][discipline.name][classification.name][week.name][0..num_racers] = time_entry
    @results = {}

    # racer_weekly_entries[racer.name][week] = time_entry
    @racer_weekly_entries = {}

    # total_points[racer_name] = int
    @total_points = {}

    # total_time[racer_name] = decimal
    @total_time = {}

    genders.each do |gender|
      @results[gender] = {}
      Discipline.all.each do |discipline|
        @results[gender][discipline.name] = {}
        Classification.all.each do |classification|
          @results[gender][discipline.name][classification.name] = {}
          Week.all_weeks_with_times.each do |week|
            set = TimeEntry.getSet gender, discipline, classification, week
            @results[gender][discipline.name][classification.name][week.name] = set
            set.each do |time_entry|
              name = time_entry.racer.name
              week = time_entry.week.name
              # Weekly entries
              if @racer_weekly_entries[name] == nil
                @racer_weekly_entries[name] = {}
              end
              @racer_weekly_entries[name][week] = time_entry
              # Total points
              if @total_points[name] == nil
                @total_points[name] = 0
              end
              @total_points[name] += time_entry.get_points
              # Total time
              if @total_time[name] == nil
                @total_time[name] = 0
              end
              @total_time[name] += time_entry.combined
            end
          end
        end
      end
    end

  end



  def calculate_team_points

    calculate_points

    @week_names = Week.get_week_names

    # team_week_racer_entries[team][week][racer] = time_entry
    @team_week_racer_entries = {}

    # team_weekly_totals[team.name] = int
    @team_weekly_totals = {}

    # team_totals[team.name] = int
    @team_totals = {}

    Team.all.each do |team|
      @team_week_racer_entries[team.name] = {}
      @team_weekly_totals[team.name] = {}
      @team_totals[team.name] = 0
      Week.all_weeks_with_times.each do |week|
        entries = []
        team.racers.each do |racer|
          puts "#{team}|#{racer} - #{week}: #{@racer_weekly_entries[racer.name][week.name]}"
          entries << @racer_weekly_entries[racer.name][week.name]
        end

        # Only the top 4 entries count toward the team's total for the week
        entries.sort_by! {|entry| entry.get_points}
        entries.each_with_index do |entry, i|
          if i > 3
            entry.exclude_from_team
          end
        end

        @team_week_racer_entries[team.name][week.name] = {}
        @team_weekly_totals[team.name][week.name] = 0
        entries.each do |entry|
          @team_week_racer_entries[team.name][week.name][entry.racer.name] = entry
          if not entry.is_excluded_from_team?
            @team_weekly_totals[team.name][week.name] += entry.get_points
            @team_totals[team.name] += entry.get_points
          end
        end
      end
    end

    # Get a list of team names ordered by total points
    @team_names = @team_totals.keys.sort_by {|team_name| @team_totals[team_name]}.reject {|name| name == 'Individual'}

    # Get a list of team names ordered by last week's points
    last_week_name = Week.get_last_week.name
    @team_names_last_week = @team_weekly_totals.keys.sort_by {|team_name| @team_weekly_totals[team_name][last_week_name]}.reject {|name| name == 'Individual'}

    # team_racer_names[team_name][0..worst_racer] = racer.name
    @team_racer_names = {}
    Team.all.each do |team|
      @team_racer_names[team.name] = []
      racers = team.racers.sort_by { |racer| @total_points[racer]}
      racers.each do |racer|
        @team_racer_names[team.name] << racer.name
      end
    end
  end



  def only_individuals
    @results.keys.each do |gender|
      @results[gender].keys.each do |discipline|
        @results[gender][discipline].keys.each do |classification|
          @results[gender][discipline][classification].keys.each do |week|
            i = 0
            while i < @results[gender][discipline][classification][week].size
              time_entry = @results[gender][discipline][classification][week][i]
              if not time_entry.racer.is_individual
                @results[gender][discipline][classification][week].delete_at(i)
              else
                i += 1
              end
            end
          end
        end
      end
    end
  end


  # Recursively delete any hash keys with empty values
  def delete_blanks(hash)
    hash.delete_if do |k, v|
      (v.respond_to?(:empty?) ? v.empty? : !v) or v.instance_of?(Hash) && (delete_blanks v).empty?
    end
  end


end