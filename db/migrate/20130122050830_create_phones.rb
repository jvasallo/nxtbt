class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :manufacturer
      t.string :name
      t.float :rating
      t.string :os
      t.text :description
      t.float :screen_size
      t.float :weight
      t.date :release_date

      t.timestamps
    end
  end
end
