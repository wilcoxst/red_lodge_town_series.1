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
    genders = %w(F M)

    @total_points = {}

    # Prepare data structure for results
    @results = Hash.new
    genders.each do |gender|
      @results[gender] = Hash.new
      Discipline.all.each do |discipline|
        @results[gender][discipline.name] = Hash.new
        Classification.all.each do |classification|
          @results[gender][discipline.name][classification.name] = Hash.new
          Week.all.each do |week|
            set = TimeEntry.getSet gender, discipline, classification, week
            @results[gender][discipline.name][classification.name][week.name] = set
            set.each do |time_entry|
              if @total_points[time_entry.racer.name] == nil
                @total_points[time_entry.racer.name] = 0
              end
              @total_points[time_entry.racer.name] += time_entry.get_points
            end
          end
        end
      end
    end

    # Fill the data structure
    # TimeEntry.all.each do |time_entry|
    #   racer = time_entry.racer
    # end
  end


  def individual_results
    #@racers = Racers.where()
  end

  private

  def get_empty_time_array
    [999.99]
  end

end