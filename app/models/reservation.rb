class Reservation < ApplicationRecord
  after_save :create_checkout_checkin_mission
  before_destroy :destroy_checkout_checkin_mission

  belongs_to :listing

  private

  def create_checkout_checkin_mission
    Mission.create(listing:, date: end_date, mission_type: 'checkout_checkin')
  end

  def destroy_checkout_checkin_mission
    Mission.find_by(listing:, date: end_date, mission_type: 'checkout_checkin').destroy
  end
end
