class HomeController < ApplicationController
  def index
    if params[:city]
      @city = City.where(alias: params[:city]).first
    end

    unless @city
      @city = City.first
    end

    @roofs = Roof.all
  end
end
