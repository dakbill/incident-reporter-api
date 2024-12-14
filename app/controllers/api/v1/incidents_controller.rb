class Api::V1::IncidentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: Incident.all
  end

  def show
    @incident = Incident.find(params[:id])
    render json: @incident.as_json(include: { locations: {}, actors: {}, items: {} })
  end

  def create
    incident = Incident.create({ status: params[:status], description: params[:description], time_of_incident: params[:time_of_incident] })
    actors = []
    locations = []
    items = []

    params[:suspects].each do |suspect|
      actors.append({ is_victim: false, name: suspect[:name], incident_id: incident.id })
    end

    params[:victims].each do |victim|
      actors.append({ is_victim: true, name: victim[:name], incident_id: incident.id })
    end

    params[:location].each do |o|
      locations.append({ lat: o[:lat], lng: o[:lng], incident_id: incident.id })
    end

    params[:implements].each do |o|
      items.append({ is_implement: true, name: o[:name], incident_id: incident.id })
    end

    params[:items].each do |o|
      items.append({ is_implement: false, name: o[:name], incident_id: incident.id })
    end

    Actor.insert_all(actors)
    Location.insert_all(locations)
    Item.insert_all(items)


    render json: {}
  end

  def update
    render json: {}
  end

  def destroy
    render json: Incident.destroy(params[:id])
  end
end
