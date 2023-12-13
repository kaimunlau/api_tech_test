class BookingsController < ApplicationController
  def index
    listing = Listing.find(params[:listing_id])
    bookings = listing.bookings
    render json: { bookings: }
  end

  def create
    listing = Listing.find(params[:listing_id])
    booking = listing.bookings.create(booking_params)
    if booking.save
      render json: { booking: }, status: :created
    else
      render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.permit(:start_date, :end_date)
  end
end
