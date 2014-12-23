class Team < ActiveRecord::Base
  has_many :racers


  private


  # TODO: Move to settings
  INDIVIDUAL_TEAM_NAME = 'Individual'

  @@individual_id = Team.find_by_name(INDIVIDUAL_TEAM_NAME).id

  def self.get_individual_id
    # if @@individual_id == -1
    #   @@individual_id = Team.find_by_name(INDIVIDUAL_TEAM_NAME)
    # end
    @@individual_id
  end
end
