class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name, index: { unique: true }
      t.string :email, index: { unique: true }
      t.integer :role

      t.timestamps
    end
  end
end
