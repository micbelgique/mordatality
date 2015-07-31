# Provinces

['Anvers', 'Hainaut', 'Flandre orientale', 'Flandre occidentale', 'Namur',
 'Liège', 'Limbourg', 'Luxembourg', 'Brabant wallon', 'Brabant flamand',
 'Bruxelles-Capitale'].each do |province|
  Province.create!(:name_fr => province)
end

# Cities

cities = JSON.load(File.new("data/postal-codes/zipcode-belgium.json"))

cities.each do |city|
  City.create(
    :name_fr      => city['city'],
    :zip          => city['zip'],
    :latitude     => city['lat'],
    :longitude    => city['lng'],
    :province_id  => Province.find_by_code(city['zip']).try(:id)
  )
end

# More data to cities

xlsx  = Roo::Excelx.new("data/postal-codes/communes-de-belgique.xlsx")
sheet = xlsx.sheet('Communes')

(1..sheet.last_row).each do |row_index|
  if row_index != 1
    if city = City.find_by_name_fr(sheet.cell(row_index, 1))
      city.update_attributes(:name_nl => sheet.cell(row_index, 2))
    end
  end
end

City.all.each do |city|
  if !city.name_nl
    city.update_attributes(:name_nl => city.name_fr)
  end
end

# Mortality Rate

xlsx = Roo::Excelx.new("data/mortality-tables-gender/TMAR_2011-2013 toutes entités_FR_tcm326-255869.xlsx")

Province.all.each do |province|
  sheet = xlsx.sheet(province.name_fr)

  { 'M' => 0, 'F' => 6 }.each_pair do |sex, offset|
    (4..109).each do |row_index|
      Mortality.create(
        :province_id           => province.id,
        :gender                => sex,
        :age                   => row_index == 4 ? -1 : sheet.cell(row_index, offset + 2),
        :sample_population     => sheet.cell(row_index, offset + 3),
        :observed_deaths       => sheet.cell(row_index, offset + 4),
        :death_probability     => sheet.cell(row_index, offset + 5),
        :survivors             => sheet.cell(row_index, offset + 6),
        :observed_table_deaths => sheet.cell(row_index, offset + 7),
        :life_expectancy       => sheet.cell(row_index, offset + 8)
      )
    end
  end
end
