class User < ApplicationRecord
	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
		user.provider = auth.provider
		user.uid = auth.uid
		user.name = auth.info.name
		user.email = auth.info.email
		user.image = auth.info.image
		user.oauth_token = auth.credentials.token
		user.oauth_refresh_token = auth.credentials.refresh_token
		user.oauth_expires_at = Time.at(auth.credentials.expires_at)
		user.save!
		@user = user
		end
	end

	def update_token(auth_hash)
			self.oauth_token = auth_hash["credentials"]["token"]
			self.save
 	end

end
