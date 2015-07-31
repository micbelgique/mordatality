class EstimationsController < ApplicationController
  def create
    sleep 3

    @estimation = EstimationService.new(
      params[:age   ].to_i,
      params[:gender],
      params[:city  ].to_i
    ).estimate
  end
end
