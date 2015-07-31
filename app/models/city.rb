class City < ActiveRecord::Base
  belongs_to :province

  enum :status => [ :city, :municipality ]

  def name
    name_fr
  end
end
