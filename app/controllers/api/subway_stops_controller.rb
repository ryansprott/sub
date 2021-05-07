module Api
  class SubwayStopsController < ApplicationController
    def index
      stops = SubwayStop.order(:gtfs_id).uniq.map do |stop|
        {
          label: stop.label,
          value: stop.gtfs_id,
        }
      end

      render json: stops
    end

    def show
      stop = SubwayStop.find_by(gtfs_id: params[:id])

      arrivals = SubwayService.get_arrivals(stop)

      render json: arrivals
    end
  end
end
