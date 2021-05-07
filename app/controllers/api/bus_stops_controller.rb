module Api
  class BusStopsController < ApplicationController
    def index
      stops = BusStop.order(:code).uniq.map do |stop|
        {
          label: stop.label,
          value: stop.code,
        }
      end

      render json: stops
    end

    def show
      arrivals = BusService.get_arrivals(params[:id])

      render json: arrivals
    end
  end
end
