class CreateItineraries < ActiveRecord::Migration[5.2]
  def change
    create_table :itineraries do |t|
      t.string :destinations
      t.text :travel_guide
      t.string :schedule
      t.integer :user_id
    end
  end
end
