class CreateTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :tokens, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.integer :access, null: false, type: :uuid, default: 0
      t.integer :status, default: 1
      
      t.timestamps
    end
  end
end