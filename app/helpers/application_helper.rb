module ApplicationHelper

  def hbr(target)
    target = html_escape(target)
    target.gsub(/\r\n|\r|\n/, "<br />")
  end

  def user_icon(user)
    user.image? ? user.image_url : asset_path("user/1.jpg")
  
  end

end
