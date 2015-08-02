class EstimationService

  attr_reader :age, :gender, :province_id

  def initialize(date_of_birth, gender, province_id)
    @date_of_birth = date_of_birth
    @gender        = gender
    @province_id   = province_id
  end

  def estimate
    mortality = Mortality.where({
      :age         => self.age,
      :gender      => gender,
      :province_id => province_id
    }).first

    if mortality
      hours_before_death = fractional_day_to_hours(mortality.life_expectancy)
      datetime_of_death  = Time.now + hours_before_death.hours

      return {
        :age               => (self.age + mortality.life_expectancy).to_i,
        :datetime_of_death => datetime_of_death,
        :death_countdown   => datetime_of_death - Time.now
      }
    end
  end

  # from: http://stackoverflow.com/questions/819263/get-persons-age-in-ruby
  def age
    now = Time.now.utc.to_date
    now.year - @date_of_birth.year - ((now.month > @date_of_birth.month || (now.month == @date_of_birth.month && now.day >= @date_of_birth.day)) ? 0 : 1)
  end


  def fractional_day_to_hours(years)
    (years * 365 * 24).to_i
  end
end
