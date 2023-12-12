class Booking < ApplicationRecord
  belongs_to :listing
  has_one :reservation, through: :listing, dependent: :destroy
end
