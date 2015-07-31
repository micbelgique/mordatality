class EstimationService

  def initialize(age, gender, city)
    @age    = age
    @gender = gender
    @city   = city
  end

  def estimate
    @age + rand(20)
  end

end
