class Mission < ApplicationRecord
  belongs_to :listing

  before_save :calculate_price

  validates :date, presence: true, uniqueness: { scope: :listing, message: 'There is already a mission on this date' }
  validates :mission_type, presence: true, inclusion: { in: %w[first_checkin last_checkout checkout_checkin] }

  private

  def calculate_price
    case mission_type
    when 'first_checkin'
      unit_price = 10
    when 'last_checkout'
      unit_price = 5
    when 'checkout_checkin'
      unit_price = 10
    end
    self.price = unit_price * listing.num_rooms
  end
end
