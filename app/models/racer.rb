class Racer < ActiveRecord::Base
  belongs_to :team
  belongs_to :discipline
  belongs_to :classification
end
