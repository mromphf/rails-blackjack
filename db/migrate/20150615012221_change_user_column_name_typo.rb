class ChangeUserColumnNameTypo < ActiveRecord::Migration
  def change
    rename_column :users, :ouath_expires_at, :oauth_expires_at
  end
end
