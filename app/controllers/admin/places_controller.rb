class Admin::PlacesController < ApplicationController
  before_action :check_admin_access
  before_action :set_place, only: [:destroy]
  
  # GET /admin/places.json
  def index
    @places = Place.all

    render json: { places: @places }
  end

  # POST /admin/places.json
  def create
    @place = Place.new(place_params)

    if @place.save
      render json: {place: @place}, status: :ok
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # DELETE /admin/places/:id.json
  def destroy
    if @place.destroy
      render json: {message: 'Place destroyed'}, status: :ok
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  private
    def set_place
      @place = Place.find(params[:id])
    end

    def place_params
      params.require(:place).permit(:name, :uri)
    end
end
