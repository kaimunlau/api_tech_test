class ListingsController < ApplicationController
  def index
    response = { listings: Listing.all }
    respond_to do |format|
      format.json { render json: response }
    end
  end
end
