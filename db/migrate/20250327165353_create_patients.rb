class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :contact
      t.text :problem
      t.date :appointment
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
