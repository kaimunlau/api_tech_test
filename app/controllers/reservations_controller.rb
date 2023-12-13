class ReservationsController < ApplicationController
  def index
    listing = Listing.find(params[:listing_id])
    reservations = listing.reservations
    render json: { reservations: }
  end

  def create
    listing = Listing.find(params[:listing_id])
    reservation = listing.reservations.create(reservation_params)
    overlapping_reservations = find_overlapping_reservations(listing, reservation)
    handle_response(reservation, overlapping_reservations)
  end

  private

  def handle_response(reservation, overlapping_reservations)
    if valid_reservation?(reservation, overlapping_reservations)
      handle_valid_reservation(reservation)
    elsif overlapping_reservations.present?
      render json: { errors: 'Dates already reserved' }, status: :unprocessable_entity
    else
      render json: { errors: 'Dates unavailable' }, status: :unprocessable_entity
    end
  end

  def handle_valid_reservation(reservation)
    if reservation.save
      render json: { reservation: }, status: :created
    else
      render json: { errors: reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def find_overlapping_reservations(listing, reservation)
    existing_reservations = listing.reservations
    existing_reservations.select do |existing_resa|
      existing_resa_range = existing_resa.start_date..existing_resa.end_date
      reservation_range = reservation.start_date..reservation.end_date
      existing_resa_range.overlaps?(reservation_range)
    end
  end

  def valid_reservation?(reservation, overlapping_reservations)
    available_dates = reservation.listing.bookings.map { |booking| booking.start_date..booking.end_date }
    overlapping_reservations.empty? &&
      available_dates.any? { |range| range.include?(reservation.start_date) || range.include?(reservation.end_date) }
  end

  def reservation_params
    params.permit(:start_date, :end_date)
  end
end
