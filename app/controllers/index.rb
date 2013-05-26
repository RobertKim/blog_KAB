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


  redirect "/profile"

end

post '/login' do
  authenticate(params[:username], params[:password])
end

get '/profile' do
  current_user
  
  @posts = Post.where(user_id: session[:user_id])
  @post_tags = @posts.map { |post| post.tags }
  @tags = @post_tags.flatten.uniq
  erb :profile
end


get '/update' do
  current_user
  
  @post = Post.find(params[:post_id])

  erb :update
end

post '/edit_post' do
  @post = Post.find(params[:post_id])
  @post.update_attributes(title: params[:title], 
                               content: params[:content])
  tags_splitter(params[:tag])
  redirect "/post/#{@post.id}"
end


post '/create_post' do
  @post = Post.create(title: params[:title], 
                             content: params[:content])
  @post.update_attributes(user_id: current_user.id)
  tags_splitter(params[:tag])
  redirect "/post/#{@post.id}"
end

get '/post/:post_id' do
  @post = Post.find(params[:post_id])

  erb :post
end


get '/tag/:tag_id' do |tag_id|

  @tag = Tag.find(tag_id)
  erb :tag
end

post '/delete' do
  @post = Post.find(params[:post_id])
  @post.destroy
  
  redirect "/profile"
end

get '/logout' do
  session.clear

  redirect "/"
end

