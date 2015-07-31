class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string     :name
      t.integer    :zip
      t.decimal    :latitude,  :precision => 16, :scale => 12
      t.decimal    :longitude, :precision => 16, :scale => 12
      t.references :province
    end
  end
end
