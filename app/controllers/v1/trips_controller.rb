module V1
  class TripsController < ApplicationController
      before_action :set_trip, only: [:show, :update, :destroy]
  
    # GET /Trips
    def index
      # @trips = current_user.trips.paginate(page: params[:page], per_page: 20)
      @trips = current_user.trips
      json_response(@trips)
    end
  
    # POST /Trips
    def create
      @trip = current_user.trips.create!(trip_params)
      json_response(@trip, :created)
    end
  
    # GET /Trips/:id
    def show
      if @trip.user.id != current_user.id and current_user.role != 'admin'
        raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
      end
      json_response(@trip)
    end
  
    # PUT /Trips/:id
    def update
      if @trip.user.id != current_user.id and current_user.role != 'admin'
        raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
      end
      @trip.update(trip_params)
      head :no_content
    end
  
    # DELETE /Trips/:id
    def destroy
      if @trip.user.id != current_user.id and current_user.role != 'admin'
        raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
      end
      @trip.destroy
      head :no_content
    end
    
    def get_all_trips
      if current_user.role == 'admin'  
        json_response(Trip.all)
      else
        raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
      end
    end
    
    private
  
    def trip_params
      # whitelist params
      params.permit(:destination, :start_date, :end_date, :comment, :trip, :id)
    end
  
    def set_trip
      @trip = Trip.find(params[:id])
    end
  end
end