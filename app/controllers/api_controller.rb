class ApiController < ApplicationController
  # require 'protobuf'
  # require 'google/transit/gtfs-realtime.pb'
  # require 'net/http'

  def all_equipment
    render json: Equipment.all
  end

  def service_status
    data = Net::HTTP.get(URI.parse('http://web.mta.info/status/ServiceStatusSubway.xml'))
    hsh  = Hash.from_xml(data)
    els  = ['Siri', 'ServiceDelivery', 'SituationExchangeDelivery', 'Situations', 'PtSituationElement']
    rsp  = hsh.dig(*els)
    out  = rsp.map do |item|
      {
        affects: item['Affects']['VehicleJourneys']['AffectedVehicleJourney'],
        consequences: item['Consequences'],
        long_description: item['LongDescription'],
        planned: item['Planned'],
        priority: item['MessagePriority'],
        start: item['PublicationWindow']['StartTime'],
        end: item['PublicationWindow']['EndTime'],
        reason: item['ReasonName'],
        summary: item['Summary']
      }
    end
    render json: out
  end

  def equipment_status
    data = Net::HTTP.get(URI.parse('http://web.mta.info/developers/data/nyct/nyct_ene.xml'))
    hsh  = Hash.from_xml(data)
    resp = {}
    hsh['NYCOutages']['outage'].each do |item|
      resp[item['borough']] = [] unless resp.has_key? item['borough']
      resp[item['borough']] << {
        station: item['station'],
        equipment_type: item['equipmenttype'],
        outage_end: item['estimatedreturntoservice'],
        outage_start: item['outagedate'],
        reason: item['reason'],
        serving: item['serving'],
        station: item['station'],
        trains: item['trainno'].split('/')
      }
    end
    render json: resp
  end

end
