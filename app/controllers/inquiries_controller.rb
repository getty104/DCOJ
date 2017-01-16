class InquiriesController < ApplicationController
	def new
		# 入力画面を表示
		@inquiry = Inquiry.new
	end
	
	def confirm
		# 入力値のチェック
		@inquiry = Inquiry.new(inquiry_params)
		if @inquiry.valid?
			# OK。確認画面を表示
			InquiryMailer.received_email(@inquiry).deliver
			redirect_to action: :thanks
		else
			# NG。入力画面を再表示
			render action: 'new'
		end
	end

	def thanks

	end
	

	private
	def inquiry_params
		params.require(:inquiry).permit(:name, :email, :message)
	end
end
