module Api
  class SubwayStopsController < ApplicationController
    def index
      stops  = SubwayStop.all.sort_by(&:gtfs_id).uniq

      output = stops.map do |stop|
        {
          label: stop.label,
          value: stop.gtfs_id
        }
      end

      render json: output
    end

    def show
      stop = SubwayStop.find_by(gtfs_id: params[:id])

      arrivals  = SubwayService.get_arrivals(stop)

      render json: arrivals
    end
  end
end
