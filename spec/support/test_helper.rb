module TestHelper
  # Return true if the test user is logged in
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Log in as a test user
  def log_in_as(user)
    session[:user_id] = user.id
  end

  def log_in_with_remember_as(user, password: 'foobar', remember_me: '0')
    post login_path,
         params: {
           session: {
             email: user.email, password: password, remember_me: remember_me
           }
         }
  end
end
