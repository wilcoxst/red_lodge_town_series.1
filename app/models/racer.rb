class Racer < ActiveRecord::Base
  belongs_to :team
  belongs_to :discipline
  belongs_to :classification
  has_many :time_entries
end
