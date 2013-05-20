helpers do
  def authenticate(username,password)
     @user = User.find_by_username(params[:username])
    if @user.password == params[:password]
      session[:user_id] = @user.id
      redirect "/profile"
    else
      redirect "/"
    end
  end
end
