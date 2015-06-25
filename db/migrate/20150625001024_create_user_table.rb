class CreateUserTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.integer :money, default: 200
      t.integer :bet, default: 0
      t.boolean :in_game, default: false

      t.timestamps
    end
  end
end
