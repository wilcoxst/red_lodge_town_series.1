class TimeEntry < ActiveRecord::Base
  belongs_to :week
  belongs_to :racer
end
