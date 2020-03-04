class Api::V1::MunchiesController < ApplicationController
  def show
    munchies = Munchies.new(strong_params)
    render json: MunchiesSerializer.new(munchies)
  end

  private

  def strong_params
    params.permit(:start, :end, :food)
  end
end
