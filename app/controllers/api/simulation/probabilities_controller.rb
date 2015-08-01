class Api::Simulation::ProbabilitiesController < ActionController::Base
  def index
    render :json => nil
  end

  def show
    render :json => {
      :birth        => ProbabilityService.birth_probability,
      :male_death   => ProbabilityService.male_death_probability(params[:id]),
      :female_death => ProbabilityService.female_death_probability(params[:id])
    }
  end
end
