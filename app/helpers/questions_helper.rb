module QuestionsHelper
   def format(text)
    return text if text.nil?
    text = h text
    text.gsub(/\r\n|\r|\n/, "
      ").html_safe
  end
end
