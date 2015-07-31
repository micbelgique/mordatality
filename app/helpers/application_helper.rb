module ApplicationHelper
  def age_options
    (0..110).to_a.collect do |age|
      ["#{age} ans", age]
    end
  end

  def gender_options
    [
      ['Je suis un homme',   'M'],
      ['Je suis une femmme', 'F'],
    ]
  end
end
