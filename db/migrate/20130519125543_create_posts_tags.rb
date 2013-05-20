class CreatePostsTags < ActiveRecord::Migration

  def change
    create_table :posts_tags do |t|
      t.references :post
      t.references :tag
    end
  end

end
