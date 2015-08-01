class CreateBirths < ActiveRecord::Migration
  def change
    create_table :births do |t|
      t.integer :age
      t.decimal :probability, :precision => 10, :scale => 8
    end
  end
end
