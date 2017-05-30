class InquiryMailer < ActionMailer::Base
	default from: ENV['EMAIL']  # 送信元アドレス

	def received_email(inquiry)
		@inquiry = inquiry
		mail(
			to:      ENV['EMAIL'],
			subject: 'お問い合わせを承りました'
			) do |format|
			format.html
		end
	end



end