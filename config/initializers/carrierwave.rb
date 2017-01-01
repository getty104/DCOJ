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
    :aws_access_key_id      => ENV['ACCESS'],
    :aws_secret_access_key  => ENV['SECRET'],
    :region                 => 'ap-northeast-1',
    :path_style             => true
  }


  config.fog_attributes = {'Cache-Control' => 'public, max-age=86400'}
   # S3のURLに直アクセス禁止
   config.fog_public = false

  # S3のURLに有効期限を60秒で設定する
   config.fog_authenticated_url_expiration = 60
  case Rails.env
    when 'production'
      config.fog_directory = 'dcoj'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/dcoj'

    when 'development'
      config.fog_directory = 'dcoj-dev'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/dcoj-dev'

    when 'test'
      config.fog_directory = 'test.dummy'
      config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/test.dummy'
  end

end