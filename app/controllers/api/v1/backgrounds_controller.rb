class Api::V1::BackgroundsController < ApplicationController
  def show
    background = UnsplashService.new.background(params[:location])
    render json: BackgroundSerializer.new(background)
  end
end
