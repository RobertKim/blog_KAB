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

  erb :profile
end


get '/update' do
  current_user
  
  @post = Post.find(params[:post_id])

  erb :update
end

post '/edit_post' do
  p params
  @edit_post = Post.find(params[:post_id])
  p params
  @edit_post.update_attributes(title: params[:title], 
                               content: params[:content])
  tags_string = params[:tag]
  if tags_string.include?(',')
    tags_array = tags_string.split(',')
    tags_array.each do |tag|
      tag = tag.strip
      @tag = Tag.find_or_create_by_name(name: tag)
      @edit_post.tags << @tag
    end
  else tags_array = tags_string.split
    tags_array.each do |tag|
      @tag = Tag.find_or_create_by_name(name: tag)
      @edit_post.tags << @tag
    end
  end 


  redirect "/post/#{@edit_post.id}"
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
      @tag = Tag.find_or_create_by_name(name: tag)
      @create_post.tags << @tag
    end
  else tags_array = tags_string.split
    tags_array.each do |tag|
      @tag = Tag.find_or_create_by_name(name: tag)
      @create_post.tags << @tag
    end
  end


  redirect "/post/#{@create_post.id}"
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

