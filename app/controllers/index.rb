get '/' do
  @tags = Tag.all
  erb :index
end

post '/signup' do
  @user = User.create(first_name: params[:first_name],
                      last_name: params[:last_name],
                      username: params[:username],
                      email: params[:email],
                      password: params[:password])
  session[:user_id] = @user.id 
  p session[:user_id]

  redirect "/profile"

end

post '/login' do
  authenticate(params[:username], params[:password])
end

get '/profile' do
  current_user
  p current_user
  @posts = Post.where(user_id: session[:user_id])

  erb :profile
end

post '/create_post' do
  @create_post = Post.create(title: params[:title], 
                             content: params[:content])
  @create_post.update_attributes(user_id: current_user.id)
  tags_string = params[:tag]
  if tags_string.include?(',')
    tags_array = tags_string.split(',')
    tags_array.each do |tag|
      tag = tag.strip
      @tag = Tag.create(name: tag)
      @create_post.tags << @tag
    end
  else tags_array = tags_string.split
    tags_array.each do |tag|
      @tag = Tag.create(name: tag)
      @create_post.tags << @tag
    end
  end


  redirect "/post/#{@create_post.id}"
end

get '/post/:post_id' do
  @post = Post.find(params[:post_id])

  erb :post
end





get 'tag/:tag_id' do
  

  erb :tag
end

post '/tag/:tag_id' do
  @tag = Tag.find

end

get '/logout' do
  session.clear

  redirect "/"
end

