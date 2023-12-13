class ReservationsController < ApplicationController
  def index
    listing = Listing.find(params[:listing_id])
    reservations = listing.reservations
    render json: { reservations: }
  end

  def create
    listing = Listing.find(params[:listing_id])
    reservation = Reservation.new(reservation_params)
    overlapping_reservations = find_overlapping_reservations(listing, reservation)
    handle_response(listing, reservation, overlapping_reservations)
  end

  def update
    reservation = Reservation.find(params[:id])
    if reservation.update(reservation_params)
      render json: { reservation: }, status: :ok
    else
      render json: { errors: reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def handle_response(listing, reservation, overlapping_reservations)
    if overlapping_reservations.present?
      render json: { errors: 'Dates already reserved' }, status: :unprocessable_entity
    elsif valid_reservation?(listing, reservation)
      reservation.listing = listing
      handle_valid_reservation(reservation)
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

  def valid_reservation?(listing, reservation)
    available_dates = listing.bookings.map { |booking| booking.start_date..booking.end_date }
    available_dates.any? { |range| range.include?(reservation.start_date) || range.include?(reservation.end_date) }
  end

  def reservation_params
    params.permit(:start_date, :end_date)
  end
end
