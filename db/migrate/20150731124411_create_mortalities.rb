class CreateMortalities < ActiveRecord::Migration
  def change
    create_table :mortalities do |t|
      t.references :province
      t.string     :gender
      t.integer    :age
      t.integer    :sample_population
      t.integer    :observed_deaths
      t.decimal    :death_probability,     :precision => 8,  :scale => 6
      t.decimal    :survivors,             :precision => 12, :scale => 4
      t.decimal    :observed_table_deaths, :precision => 12, :scale => 4
      t.decimal    :life_expectancy,       :precision => 4,  :scale => 2
    end
  end
end
