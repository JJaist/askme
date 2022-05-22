module QuestionsHelper

  def author_present(author)
    if author == current_user && current_user.present?
    "мой вопрос"
    elsif author.present?
      link_to "вопрос от #{ display_nickname(author) }", user_path(author)
    else
      "вопрос от анонима"
    end
  end
end
