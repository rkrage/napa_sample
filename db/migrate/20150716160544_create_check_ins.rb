class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6
      t.string :name, null: false
      t.string :message, null: false
      t.belongs_to :user, index: true, null: false

      t.timestamps
    end
  end
end