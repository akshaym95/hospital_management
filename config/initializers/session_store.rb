# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_Hospital_Management_System_session',
  :secret      => '5c21171d4f8aa8a57549dd105436b3719de490617a583a6bbcd086794789806844d7295a22c9de276c1b79638e4efc287c669d7d2fd0e673adf9ba386aa6e86d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
