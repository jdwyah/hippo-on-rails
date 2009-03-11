# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hippo-on-rails_session',
  :secret      => 'ad1ea4299dec84c9fef5ecb749393b78bb919d6f48ada08949f2232988ff990b929167feb5dff0c5c9efb3e297878e677b6195f02e337e571a160aa4b8fbf2ed'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
