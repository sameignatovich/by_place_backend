class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :fullname
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest
      t.boolean :admin, default: false
      t.boolean :email_confirmed, default: false
      t.uuid :email_confirmation_token, default: -> { "gen_random_uuid()" }
      t.uuid :password_reset_token
      t.datetime :password_reset_sent_at

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
    add_index :users, :email_confirmation_token, unique: true
    add_index :users, :password_reset_token, unique: true
  end
end
