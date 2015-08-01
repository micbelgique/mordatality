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
    :name_nl      => city['city'],
    :zip          => city['zip'],
    :latitude     => city['lat'],
    :longitude    => city['lng'],
    :province_id  => Province.find_by_zip_code(city['zip']).try(:id)
  )
end

# More data to cities

xlsx  = Roo::Excelx.new("data/postal-codes/communes-de-belgique.xlsx")
sheet = xlsx.sheet('Communes')

# Update name_nl of cities
(2..sheet.last_row).each do |row_index|
  if city = City.find_by_name_fr(sheet.cell(row_index, 1))
    City.where(:name_fr => sheet.cell(row_index, 1)).update_all(:name_nl => sheet.cell(row_index, 2))
  elsif city = City.find_by_name_nl(sheet.cell(row_index, 2))
    City.where(:name_nl => sheet.cell(row_index, 2)).update_all(:name_fr => sheet.cell(row_index, 1))
  end
end

# Update kind, area, population and density of cities
(2..sheet.last_row).each do |row_index|
  city_fr = City.find_by_name_fr(sheet.cell(row_index, 1))
  city_nl = City.find_by_name_nl(sheet.cell(row_index, 1))

  city = city_fr ? city_fr : city_nl

  if city
    city.update_attributes(
      :kind       => sheet.cell(row_index, 3) == 'Ville' ? :city : :municipality,
      :area       => sheet.cell(row_index, 5),
      :population => sheet.cell(row_index, 6),
      :density    => sheet.cell(row_index, 7)
    )
  end
end

# Update kind=section and parent_id of cities
(2..sheet.last_row).each do |row_index|
  sections = sheet.cell(row_index, 8).split(',').collect(&:strip)

  sections.each do |section|
    city_fr = City.find_by_name_fr(section)
    city_nl = City.find_by_name_nl(section)
    city    = city_fr ? city_fr : city_nl

    if city && city.kind.nil?
      city.update_attributes(:kind => :section)
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
        :age                   => row_index == 4 ? -1 : sheet.cell(row_index, 2),
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
