module Api
  class BusStopsController < ApplicationController
    def index
      stops = BusStop.by_code

      render json: stops
    end

    def show
      arrivals = BusService.get_arrivals(params[:id])

      render json: arrivals
    end
  end
end
