module ApplicationHelper
  def age_options
    (0..110).to_a.collect do |age|
      [age, age]
    end
  end

  def gender_options
    [
      ['Male',   'M'],
      ['Female', 'F'],
    ]
  end
end
