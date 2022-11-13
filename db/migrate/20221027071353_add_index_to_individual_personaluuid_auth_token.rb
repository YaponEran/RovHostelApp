class AddIndexToIndividualPersonaluuidAuthToken < ActiveRecord::Migration[6.1]
  def change
    add_index :individuals, :personal_uuid, unique: true
    add_index :individuals, :auth_token, unique: true
  end
end
