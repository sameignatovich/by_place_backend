class V1::PlacesController < ApplicationController
  before_action :set_place, only: [:show, :update, :destroy]

  # GET /v1/places
  def index
    @places = Place.all
  end

  # GET /v1/places/1
  def show
  end

  # POST /v1/places
  def create
    @place = Place.new(place_params)

    if @place.save
      render json: @place, status: :created, location: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/places/1
  def update
    if @place.update(place_params)
      render json: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/places/1
  def destroy
    @place.destroy
  end

  private
    def set_place
      @place = Place.find_by(uri: params[:uri])
    end

    def place_params
      params.require(:place).permit(:name, :uri)
    end
end
