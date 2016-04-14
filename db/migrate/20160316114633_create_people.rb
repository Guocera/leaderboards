class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :email
      t.string :last_name
      t.string :first_name
      t.string :employer
      t.string :bio
      t.integer :capital_amount_in_cents
      t.integer :donations_amount_in_cents
      t.integer :donations_count
      t.boolean :is_leaderboardable
      t.integer :signup_type

      t.timestamps null: false
    end
  end
end
