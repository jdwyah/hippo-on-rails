class User < ActiveRecord::Base

  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
    c.transition_from_crypto_providers = Authlogic::CryptoProviders::MD5
  end
  
  has_many :topics
end
