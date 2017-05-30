module CarrierWave
	module RMagick

		def quality(percentage)
			manipulate! do |img|
				img.write(current_path){ self.quality = percentage } unless img.quality == percentage
				img = yield(img) if block_given?
				img
			end
		end

	end
end

CarrierWave.configure do |config|
	config.fog_provider = 'fog/aws'
	config.fog_credentials = {
		:provider               => 'AWS',
		:aws_access_key_id      => ENV['AWS_ACCESS'],
		:aws_secret_access_key  => ENV['AWS_SECRET'],
		:region                 => ENV['REGEON'],
		:path_style             => true
	}


	config.fog_attributes = {'Cache-Control' => 'public, max-age=86400'}
	 # S3のURLに直アクセス禁止
	 config.fog_public = false

	# S3のURLに有効期限を60秒で設定する
	config.fog_authenticated_url_expiration = 60
	case Rails.env
	when 'production'
		config.asset_host = ENV['PRODUCTION_S3_URL']

	when 'development'
		config.fog_directory = 'dcoj-dev'
		config.asset_host = ENV['DEV_S3_URL']

		#when 'test'
		config.fog_directory = 'test.dummy'
		config.asset_host = ENV['TEST_S3_URL']
	end

end