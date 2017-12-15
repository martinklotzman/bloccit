module UsersHelper
  def posts_comments_view(association)
    if @user.send(association).any?
      render @user.send(association)
    else
       content_tag(:p, "#{@user.name} has not submitted any #{association.to_s}")
     end
  end
end
