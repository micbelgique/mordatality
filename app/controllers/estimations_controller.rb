class EstimationsController < ApplicationController
  def create
    @estimation = EstimationService.new(
      params[:age   ].to_i,
      params[:gender],
      params[:city  ].to_i
    ).estimate
  end
end
