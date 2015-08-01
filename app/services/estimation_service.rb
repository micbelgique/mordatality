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
      (self.age + mortality.life_expectancy).to_i
    end
  end

  # from: http://stackoverflow.com/questions/819263/get-persons-age-in-ruby
  def age
    now = Time.now.utc.to_date
    now.year - @date_of_birth.year - ((now.month > @date_of_birth.month || (now.month == @date_of_birth.month && now.day >= @date_of_birth.day)) ? 0 : 1)
  end
end
