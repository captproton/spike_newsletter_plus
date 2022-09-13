class AddEmailToPublication < ActiveRecord::Migration[7.0]
  def change
    add_column :publications, :email, :string
  end
end
