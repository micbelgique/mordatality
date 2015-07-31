class Province < ActiveRecord::Base
  def self.find_by_code(code)
    postal_code = postal_code.to_i

    if postal_code.between?(1000, 1299)
      name = 'Bruxelles-Capitale'
    elsif postal_code.between?(1300, 1499)
      name = 'Brabant wallon'
    elsif postal_code.between?(1500, 1999)
      name = 'Braband flamand'
    elsif postal_code.between?(2000, 2999)
      name = 'Anvers'
    elsif postal_code.between?(3000, 3499)
      name = 'Brabant flamand'
    elsif postal_code.between?(3500, 3999)
      name = 'Limbourg'
    elsif postal_code.between?(4000, 4999)
      name = 'Liège'
    elsif postal_code.between?(5000, 5999)
      name = 'Namur'
    elsif postal_code.between?(6000, 6599)
      name = 'Hainaut'
    elsif postal_code.between?(6600, 6999)
      name = 'Luxembourg'
    elsif postal_code.between?(7000, 7999)
      name = 'Hainaut'
    elsif postal_code.between?(8000, 8999)
      name = 'Flandre occidentale'
    elsif postal_code.between?(9000, 9999)
      name = 'Flandre orientale'
    end

    find_by_name_fr(name)
  end
end
