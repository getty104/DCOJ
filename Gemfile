source 'https://rubygems.org'


ruby '2.3.3'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1', '>= 5.0.0.1'
# Use sqlite3 as the database for Active Record
# Use Puma as the app server
gem 'mathjax-rails'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'foreigner'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'dotenv-rails'
gem 'kaminari'
#Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'therubyracer' # javascript runtime。lessをコンパイルするために必要
gem 'less-rails' # Railsでlessを使えるようにする。Bootstrapがlessで書かれているため
gem 'twitter-bootstrap-rails' # Bootstrapの本体
gem 'resonance'
#無限スクロール
gem 'jquery-turbolinks'
gem 'sprockets-rails', '2.3.3'
gem 'puma', '~> 3.0'
#フォント
gem "font-awesome-rails"
#画像アップロード
gem "aws-sdk"
gem 'carrierwave'
gem 'rmagick'
gem 'cloudinary'
# For Carrierwave
gem 'fog-aws'
#自動処理
	gem 'pg', '~> 0.18'
gem 'whenever', require: false
gem 'devise'
group :development, :test do
	# Call 'byebug' anywhere in the code to stop execution and get a debugger console
	gem 'byebug', platform: :mri
end

group :development do
	# エラー画面をわかりやすく整形してくれる
	gem 'better_errors'

	# better_errorsの画面上にirb/pry(PERL)を表示する
	gem 'binding_of_caller'

	# Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
	gem 'web-console'
	gem 'listen', '~> 3.0.5'
	# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
	gem 'spring'
	gem 'spring-watcher-listen', '~> 2.0.0'
	gem "rails-erd"
	gem 'bullet'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :production do
	gem 'newrelic_rpm'

	gem 'rails_12factor'
	gem 'heroku-deflater'
end




