class AddReferenceGradingUser < ActiveRecord::Migration
  def change

          add_reference :gradings, :user, references: :users, index: true
          add_foreign_key :gradings, :users, column: :user_id
  end
end
