module Api
  class BusStopsController < ApplicationController
    def index
      stops  = BusStop.all.sort_by(&:code).uniq

      output = stops.map do |stop|
        {
          label: stop.label,
          value: stop.code
        }
      end

      render json: output
    end

    def show
      arrivals = BusService.get_arrivals(params[:id])

      render json: arrivals
    end
  end
end
