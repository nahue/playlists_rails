class AddUserToBands < ActiveRecord::Migration[8.0]
  def change
    # First add the column as nullable
    add_reference :bands, :user, foreign_key: true

    # If there are existing bands, we need to handle them
    # For now, we'll make the column nullable and handle it in the application
    # In a real app, you might want to assign existing bands to a default user
  end
end
