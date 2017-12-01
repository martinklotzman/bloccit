module TopicsHelper
  def user_is_authorized_to_create_delete_topics?
     current_user && current_user.admin?
  end

  def user_is_authorized_to_edit_topics?
    current_user && (current_user.admin? || current_user.moderator?)
  end

  def user_is_authorized_for_create_posts?
    current_user && (current_user.member? && current_user.admin?)
  end
end
