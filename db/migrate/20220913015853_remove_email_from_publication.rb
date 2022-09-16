class RemoveEmailFromPublication < ActiveRecord::Migration[7.0]
  def change
    remove_column :publications, :email, :string
  end
end
