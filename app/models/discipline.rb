class Discipline < ActiveRecord::Base
  has_many :racers

  def to_s
    name
  end

end
