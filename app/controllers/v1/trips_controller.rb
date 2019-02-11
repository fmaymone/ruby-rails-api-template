module V1
  class TripsController < ApplicationController
      before_action :set_trip, only: [:show, :update, :destroy]
  
    # GET /Trips
    def index
      @trips = current_user.trips.paginate(page: params[:page], per_page: 20)
      json_response(@trips)
    end
  
    # POST /Trips
    def create
      @trip = current_user.trips.create!(trip_params)
      json_response(@trip, :created)
    end
  
    # GET /Trips/:id
    def show
      json_response(@trip)
    end
  
    # PUT /Trips/:id
    def update
      @trip.update(trip_params)
      head :no_content
    end
  
    # DELETE /Trips/:id
    def destroy
      @trip.destroy
      head :no_content
    end
  
    private
  
    def trip_params
      # whitelist params
      params.permit(:destination)
    end
  
    def set_trip
      @trip = Trip.find(params[:id])
    end
  end
end