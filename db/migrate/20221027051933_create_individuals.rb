class CreateIndividuals < ActiveRecord::Migration[6.1]
  def change
    create_table :individuals do |t|
      t.string :title, null: false
      t.string :judicial_adress, null: false
      t.string :postal_adress, null: false
      t.string :personal_uuid
      t.string :auth_token
      
      t.timestamps
    end
  end
end
