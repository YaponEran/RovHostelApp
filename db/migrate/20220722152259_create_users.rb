class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false, default:  ""
      t.string :last_name,  null: false, default:  ""
      t.string :mobile_phone, null: false, default:  ""
      t.timestamps
    end
  end
end
