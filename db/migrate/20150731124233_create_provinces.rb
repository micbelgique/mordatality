class CreateProvinces < ActiveRecord::Migration
  def change
    create_table :provinces do |t|
      t.string :name_fr
      t.string :name_nl
      t.string :name_en
      t.decimal :latitude,  :precision => 10, :scale => 6
      t.decimal :longitude, :precision => 10, :scale => 6
    end
  end
end
