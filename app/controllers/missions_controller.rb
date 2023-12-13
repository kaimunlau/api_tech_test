class MissionsController < ApplicationController
  def index
    listing = Listing.find(params[:listing_id])
    missions = listing.missions
    render json: { listing:, missions: }
  end
end
