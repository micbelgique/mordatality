class Api::Simulation::ProbabilitiesController < ActionController::Base
  def index
    render :json => nil
  end

  def show
    render :json => {
      :birth                  => ProbabilityService.birth_probability,
      :male_death             => ProbabilityService.male_death_probability(params[:id]),
      :female_death           => ProbabilityService.female_death_probability(params[:id]),
      :male_migration         => ProbabilityService.male_migration_probability,
      :female_migration       => ProbabilityService.female_migration_probability,
      :male_age_repartition   => ProbabilityService.male_age_repartition,
      :female_age_repartition => ProbabilityService.female_age_repartition
    }
  end
end
