class ResultsController < ApplicationController
  #before_action :set_week, only: [:show, :edit, :update, :destroy]

  # GET /results
  # GET /results.json
  def index
    @racers = Racer.all
    @teams = Team.all
    @weeks = Week.all
    @time_entries = TimeEntry.all
  end

  def points
    calculate_points
  end

  def individual_results
    #@racers = Racers.where()
  end

  def team_results
    calculate_team_points
    @teams = Team.all
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

    genders.each do |gender|
      @results[gender] = {}
      Discipline.all.each do |discipline|
        @results[gender][discipline.name] = {}
        Classification.all.each do |classification|
          @results[gender][discipline.name][classification.name] = {}
          Week.all.each do |week|
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

    # team_week_racer_entries[team][week][racer] = time_entry
    @team_racer_week_entries = {}

    # team_weekly_totals[team.name] = int
    @team_weekly_totals = {}

    # team_totals[team.name] = int
    @team_totals = {}


    Team.all.each do |team|
      @team_week_racer_entries[team.name] = {}
      @team_weekly_totals[team.name] = {}
      @team_totals[team.name] = 0
      Week.all.each do |week|
        entries = []
        team.racers.each do |racer|
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

  end