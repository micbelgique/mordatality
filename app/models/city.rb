class City < ActiveRecord::Base
  belongs_to :province

  enum :type => [ :city, :municipality ]

  def name
    name_fr
  end
end
