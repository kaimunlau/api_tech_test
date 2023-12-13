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

  def update
    listing = Listing.find(params[:listing_id])
    booking = listing.bookings.find(params[:id])
    if booking.update(booking_params)
      render json: { booking: }, status: :ok
    else
      render json: { errors: booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    listing = Listing.find(params[:listing_id])
    booking = listing.bookings.find(params[:id])
    booking.destroy
    head 204
  end

  private

  def booking_params
    params.permit(:start_date, :end_date)
  end
end
