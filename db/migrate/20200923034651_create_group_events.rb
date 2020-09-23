class CreateGroupEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :group_events do |t|
      t.string :name, limit: 200, index: { unique: true }
      t.text :description
      t.string :location, limit: 200
      t.boolean :published, null: false, default: false
      t.integer :duration
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
