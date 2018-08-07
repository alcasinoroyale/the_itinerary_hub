class CreateItineraries < ActiveRecord::Migration[5.2]
  def change
    create_table :itineraries do |t|
      t.string :destinations
      t.string :schedule
      t.text :travel_guide
      t.integer :user_id
    end
  end
end
