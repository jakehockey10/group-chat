class AddAppearanceToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :appearance, :integer, default: 0
  end
end
