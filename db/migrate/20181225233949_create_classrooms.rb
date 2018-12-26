class CreateClassrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :classrooms do |t|
      t.string :building_name
      t.string :room_number

      t.timestamps
    end
  end
end
