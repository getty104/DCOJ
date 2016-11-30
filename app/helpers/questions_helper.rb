module QuestionsHelper
  def created_user(question)
    User.find(question.user_id)
  end
end
