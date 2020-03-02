class Api::V1::MunchiesController < ApplicationController
  def show
    munchies = Munchies.new(params[:start], params[:end], params[:food])
    render json: MunchiesSerializer.new(munchies)
  end
end
