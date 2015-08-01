class City < ActiveRecord::Base
  belongs_to :province

  enum :kind => [ :city, :municipality, :section ]

  def name
    name_fr
  end
end
