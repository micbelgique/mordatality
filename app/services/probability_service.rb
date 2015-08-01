class ProbabilityService

  def self.birth_probability()
    Birth.all.collect do |birth|
      birth.probability
    end
  end

  def self.male_death_probability(province_id)
    Mortality.where({
      :gender      => 'M',
      :province_id => province_id
    }).collect do |mortality|
      mortality.death_probability
    end
  end

  def self.female_death_probability(province_id)
    Mortality.where({
      :gender      => 'F',
      :province_id => province_id
    }).collect do |mortality|
      mortality.death_probability
    end
  end

end
