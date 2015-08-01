class EstimationsController < ApplicationController
  def create
    sleep 3

    city        = City.find(params[:city])
    province_id = Province.find_by_zip_code(city.zip)

    @estimation = EstimationService.new(
      params[:age   ].to_i,
      params[:gender],
      province_id
    ).estimate
  end
end
