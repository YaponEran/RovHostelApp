class AddUserIndividualId < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :individual, foreign_key: true
  end
end
