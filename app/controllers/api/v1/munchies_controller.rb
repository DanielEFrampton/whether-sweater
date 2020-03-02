class Api::V1::MunchiesController < ApplicationController
  def show
    # start_location_info = GoogleApiService.new.geocode(params[:start])
    end_location_info = GoogleApiService.new.geocode(params[:end])
    distance_info = GoogleApiService.new.distance(params[:start], params[:end])
    require "pry"; binding.pry
    munchies = Munchies.new(params[:start], params[:end], params[:food])
    render json: MunchiesSerializer.new(munchies)
  end
end
