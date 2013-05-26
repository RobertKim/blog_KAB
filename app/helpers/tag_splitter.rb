helpers do

  def tags_splitter(tags_string)

   if tags_string.include?(',')
    tags_array = tags_string.split(',')
    tags_array.each do |tag|
      tag = tag.strip
      @tag = Tag.find_or_create_by_name(name: tag)
      @post.tags << @tag
    end
  else tags_array = tags_string.split
    tags_array.each do |tag|
      @tag = Tag.find_or_create_by_name(name: tag)
      @post.tags << @tag
    end
  end
end 
end


