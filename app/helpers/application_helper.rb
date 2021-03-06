module ApplicationHelper

	def hbr(target)
		target = html_escape(target)
		target.gsub(/\r\n|\r|\n/, "<br />")
	end

	def user_icon(user)
		user.image? ? user.image_url : asset_path("user/1.jpg")
	end

	def date_format(datetime)
		time_ago_in_words(datetime) + ' ago'
	end

	def rate_color(rate)
		if rate < 900
			color = '#999'
		elsif rate < 1200
			color =	'#00A900'
		elsif rate < 1500
			color = '#66F'
		elsif rate < 2200
			color = '#DC0'
		else
			color =  '#E00'
		end
		return color
	end

	require "redcarpet"
	require "coderay"

	class HTMLwithCoderay < Redcarpet::Render::HTML
		def block_code(code, language)
			if language.to_s == ''
				lang = 'md'
			else
			language = language.split(':')[0]
			case language.to_s
			when 'rb'
				lang = 'ruby'
			when 'yml'
				lang = 'yaml'
			when 'css'
				lang = 'css'
			when 'html'
				lang = 'html'
			when 'cpp'
				lang = 'c++'
			when 'c'
				lang = 'c'
			when 'py'
				lang = 'python'
			when ''
				lang = 'md'
			else
				lang = language
			end
		end

			CodeRay.scan(code, lang).div
		end
	end

	def markdown(text)
		language ||= :plaintext
		html_render = HTMLwithCoderay.new(filter_html: true, hard_wrap: true)
		options = {
			autolink: true,
			space_after_headers: true,
			no_intra_emphasis: true,
			fenced_code_blocks: true,
			tables: true,
			hard_wrap: true,
			xhtml: true,
			lax_html_blocks: true,
			strikethrough: true
		}
		markdown = Redcarpet::Markdown.new(html_render, options)
		markdown.render(text)
	end
	
end
