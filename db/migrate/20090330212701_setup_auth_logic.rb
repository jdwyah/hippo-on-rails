class SetupAuthLogic < ActiveRecord::Migration
  def self.up

    rename_column :users, :pasword, :crypted_password

    add_column :users, :password_salt, :string

    add_column :users, :persistence_token, :string
    add_column :users, :login_count, :integer
    add_column :users, :last_request_at, :datetime
    add_column :users, :last_login_at, :datetime
    add_column :users, :current_login_at, :datetime
    add_column :users, :last_login_ip, :string
    add_column :users, :current_login_ip, :string

    add_column :users, :openid_identifier, :string
    add_index :users, :openid_identifier
    add_index :users, :login

    User.connection.execute("update users set openid_identifier = login where login like '%.%'")

  end

  def self.down

    rename_column :users, :crypted_password, :pasword
    
    remove_column :users, :password_salt
    remove_column :users, :persistence_token
    remove_column :users, :login_count
    remove_column :users, :last_request_at
    remove_column :users, :last_login_at
    remove_column :users, :current_login_at
    remove_column :users, :last_login_ip
    remove_column :users, :current_login_ip

    remove_column :users, :openid_identifier
  end


end
