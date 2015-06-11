class Video < ActiveRecord::Base

  # attr_accessible :name, :autonym, :filename, :tags, :category
  
  # before_save :update_tags

  CATEGORY_ITEMS = %w{
    Movie
    Animation
    Learn
  }

  def tag_list
    return [] unless tags

    tags.split(',')
  end
end
