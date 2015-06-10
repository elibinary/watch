class Video < ActiveRecord::Base

  # attr_accessible :name, :autonym, :filename, :tags, :category
  
  # before_save :update_tags

  def tag_list
    return [] unless tags

    tags.split(',')
  end
end
