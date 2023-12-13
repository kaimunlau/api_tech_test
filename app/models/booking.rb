class Booking < ApplicationRecord
  after_save :create_first_checkin_mission, :create_last_checkout_mission
  before_destroy :destroy_first_checkin_mission, :destroy_last_checkout_mission

  belongs_to :listing
  has_one :reservation, through: :listing, dependent: :destroy

  private

  def create_first_checkin_mission
    Mission.create(listing:, date: start_date, mission_type: 'first_checkin')
  end

  def create_last_checkout_mission
    Mission.create(listing:, date: end_date, mission_type: 'last_checkout')
  end

  def destroy_first_checkin_mission
    Mission.find_by(listing:, date: start_date, mission_type: 'first_checkin').destroy
  end

  def destroy_last_checkout_mission
    Mission.find_by(listing:, date: end_date, mission_type: 'last_checkout').destroy
  end
end
