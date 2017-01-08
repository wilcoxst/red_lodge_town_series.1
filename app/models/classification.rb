class Classification < ActiveRecord::Base
  has_many :racers

  def to_s
    name
  end
end
