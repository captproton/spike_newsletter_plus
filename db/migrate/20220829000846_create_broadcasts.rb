class CreateBroadcasts < ActiveRecord::Migration[7.0]
  def change
    create_table :broadcasts do |t|
      t.string :name
      t.string :subject
      t.string :preview
      t.string :sender_name
      t.string :sender_email
      t.string :recipients_group
      t.datetime :send_at

      t.timestamps
    end
  end
end
