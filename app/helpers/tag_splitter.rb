class TagSplitter
  def self.split_tags(tags)


  end
end

puts TagSplitter.split_tags("Hell, no.") == ["hell","no"]

helpers do

  def tag_split(tags_string)
    TagSplitter.split_tags(tags_string)
  # tags_string = params[:tag]
    if tags_string.include?(',')
      tags_array = tags_string.split(',')
      tags_array.each do |tag|
        return tag = tag.strip
      end 
    else
      tags_array = tags_string.split
      tags_array.each do |tag|
        return tag
      end
    end

  end
end
