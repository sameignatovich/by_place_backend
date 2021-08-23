class Admin::PlacesController < ApplicationController

  # GET /admin/places.json
  def index
    @places = Place.all

    render json: { places: @places }
  end
end
