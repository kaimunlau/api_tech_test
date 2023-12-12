class ListingsController < ApplicationController
  def index
    response = { listings: Listing.all }
    respond_to do |format|
      format.json { render json: response }
    end
  end

  def create
    listing = Listing.new(listing_params)
    if listing.save
      render json: listing, status: 201
    else
      render json: { errors: listing.errors }, status: 422
    end
  end

  private

  def listing_params
    params.permit(:num_rooms)
  end
end
