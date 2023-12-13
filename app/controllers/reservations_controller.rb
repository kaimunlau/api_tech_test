class ReservationsController < ApplicationController
  def index
    listing = Listing.find(params[:listing_id])
    reservations = listing.reservations
    render json: { reservations: }
  end
end
