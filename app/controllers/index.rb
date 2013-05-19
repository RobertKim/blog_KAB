get '/' do
  @tags = Tag.all
  erb :index
end

post '/signup' do
  @user = User.create(first_name: params[:first_name],
                      last_name: params[:last_name],
                      email: params[:email],
                      password_hash: params[:password])
  @user.id = session[:user_id]

  redirect "/profile"

end

get '/profile/:user_id' do
  @user = User.find(params[:user_id])




get 'tag/:tag_id' do
  @tag = Tag.find(params[:tag_id])

  erb :tag
end

post '/tag/:tag_id' do
  @tag = Tag.find

end

