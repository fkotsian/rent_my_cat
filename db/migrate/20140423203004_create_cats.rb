class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.integer :age, null: false
      t.string :date, null: false
      t.string :color, null: false
      t.string :name, null: false
      t.string :sex, null: false
    end
  end
end
