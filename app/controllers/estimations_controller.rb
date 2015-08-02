class EstimationsController < ApplicationController
  def create
    sleep 3

    begin
      city        = City.find(params[:city])
      province_id = Province.find_by_zip_code(city.zip)
      date_of_birth = Date.parse(params[:date_of_birth], "%Y-%m-%d")

      @estimation = EstimationService.new(
        date_of_birth,
        params[:gender],
        province_id
      ).estimate
    rescue
      @error = "Données invalides."
    end
  end
end
