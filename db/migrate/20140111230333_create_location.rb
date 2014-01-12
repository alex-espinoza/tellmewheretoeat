class CreateLocation < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :latitude, :null => false
      t.string :longitude, :null => false
    end
  end
end
