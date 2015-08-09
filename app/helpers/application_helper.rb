module ApplicationHelper
  def age_options
    max_age = Mortality.pluck(:age).max

    (0..max_age).to_a.collect do |age|
      ["#{age} ans", age]
    end
  end

  def gender_options
    [
      ['Je suis un homme',   'M'],
      ['Je suis une femme', 'F'],
    ]
  end

  def city_options
    Province.order(:name_fr).collect do |province|
      cities = province.cities.order(:zip).collect do |city|
        [ "#{city.zip} — #{city.name_fr}", city.id ]
      end

      [ province.name_fr, cities ]
    end
  end
end
