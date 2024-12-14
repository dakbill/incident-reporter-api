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
    puts params
    incident = Incident.new({ status: params[:status], description: params[:description], time_of_incident: params[:time_of_incident] })

    (params[:suspects]||[]).each do |suspect|
      incident.actors.append(Actor.new({ is_victim: false, name: suspect[:name] }))
    end

    (params[:victims]||[]).each do |victim|
      incident.actors.append(Actor.new({ is_victim: true, name: victim[:name] }))
    end

    (params[:location]||[]).each do |o|
      incident.locations.append(Location.new({ lat: o[:lat], lng: o[:lng] }))
    end

    (params[:implements]||[]).each do |o|
      incident.items.append(Item.new({ is_implement: true, name: o[:name] }))
    end

    (params[:items] || []).each do |o|
      incident.items.append(Item.new({ is_implement: false, name: o[:name] }))
    end

    incident.save!


    render json: incident.as_json(include: { locations: {}, actors: {}, items: {} })
  end

  def update
    render json: {}
  end

  def destroy
    render json: Incident.destroy(params[:id])
  end
end
