# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_server_session',
  :secret      => 'cab5c5ca33da61df371775f5396175739bca59d24065a0ac620dcf6b532bbda6336de8cfc7b7905ba430a28a9f1da3e048de81e238c2be3079b628c62f1b4e69'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
