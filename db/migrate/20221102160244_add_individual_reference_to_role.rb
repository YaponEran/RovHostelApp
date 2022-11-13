class AddIndividualReferenceToRole < ActiveRecord::Migration[6.1]
  def change
    add_reference :roles, :individual, foreign_key: true
  end
end
