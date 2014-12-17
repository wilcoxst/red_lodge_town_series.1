class Racer < ActiveRecord::Base
  belongs_to :team
  belongs_to :discipline
  belongs_to :classification
  has_many :time_entries

  def getCategory gender, discipline, classification
    Racer.where("gender = ? AND discipline = ? AND classification = ?", gender, discipline, classification)
  end

  def self.full_gender short_gender
    if short_gender == 'F'
      'Women'
    else
      'Men'
    end

  end

  def set_points(points)
    @points = points
  end

  def add_points(points)
    if @points == nil
      @points = 0
    end
    @points += points
  end

  def get_points
    @points
  end
end
