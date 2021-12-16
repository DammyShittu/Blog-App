module UsersHelper
  def user_img(user)
    user.photo.present? ? user.photo : 'http://www.pselaw.com/wp-content/uploads/2016/08/pokemon-150x150.jpg'
  end
end
