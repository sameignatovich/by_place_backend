class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places, id: :uuid do |t|
      t.string :name, null: false
      t.string :uri, null: false

      t.timestamps
    end
    add_index :places, :uri, unique: true
  end
end
