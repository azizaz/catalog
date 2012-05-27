Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET
  provider :facebook, '420935277918608', '1978d14e5f052d9af7cee30dadf57420'
end