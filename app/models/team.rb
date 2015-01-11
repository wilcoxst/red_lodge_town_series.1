class Team < ActiveRecord::Base
  has_many :racers


  private


  # TODO: Move to settings
  INDIVIDUAL_TEAM_NAME = 'Individual'

  #@@individual_id = Team.find_by_name(INDIVIDUAL_TEAM_NAME).id
  @@individual_id = -1

  def self.get_individual_id
     if @@individual_id == -1
       @@individual_id = Team.find_by_name(INDIVIDUAL_TEAM_NAME).id
       puts 'Individual team id is ' + @@individual_id.to_s
     end
    @@individual_id
  end
end
