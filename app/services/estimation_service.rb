class EstimationService

  attr_reader :age, :gender, :province_id

  def initialize(age, gender, province_id)
    @age         = age
    @gender      = gender
    @province_id = province_id
  end

  def estimate
    mortality = Mortality.where({
      :age         => age,
      :gender      => gender,
      :province_id => province_id
    }).first

    if mortality
      (age + mortality.life_expectancy).to_i
    end
  end

end
