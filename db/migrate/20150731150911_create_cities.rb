class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string     :name_fr
      t.string     :name_nl
      t.integer    :type
      t.integer    :zip
      t.decimal    :latitude,  :precision => 16, :scale => 12
      t.decimal    :longitude, :precision => 16, :scale => 12
      t.references :province
      t.decimal    :area,      :precision => 4,  :scale => 2
      t.integer    :population
      t.integer    :density
    end
  end
end
