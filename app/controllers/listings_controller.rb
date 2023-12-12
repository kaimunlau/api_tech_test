class ListingsController < ApplicationController
  def index
    response = { listings: Listing.all }
    respond_to do |format|
      format.json { render json: response }
    end
  end

  def show
    listing = Listing.find(params[:id])
    respond_to do |format|
      format.json { render json: listing }
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

  def update
    listing = Listing.find(params[:id])
    if listing.update(listing_params)
      render json: listing, status: 200
    else
      render json: { errors: listing.errors }, status: 422
    end
  end

  def destroy
    listing = Listing.find(params[:id])
    listing.destroy
    head 204
  end

  private

  def listing_params
    params.permit(:num_rooms)
  end
end
