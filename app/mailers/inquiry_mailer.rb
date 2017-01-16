class InquiryMailer < ActionMailer::Base
	default from: "hayabusatoshihumi@gmail.com"   # 送信元アドレス

	def received_email(inquiry)
		@inquiry = inquiry
		mail(
			to:      'hayabusatoshihumi@gmail.com',
			subject: 'お問い合わせを承りました'
			) do |format|
			format.html
		end
	end



end