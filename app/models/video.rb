class Video < ActiveRecord::Base

  # attr_accessible :name, :autonym, :filename, :tags, :category, :play_url
  
  # before_save :update_tags

  CATEGORY_ITEMS = %w{
    Movie
    Animation
    Learn
    3DH
  }

  def tag_list
    return [] unless tags

    tags.split(',')
  end

  def src_url
    if self.play_url.present?
      url = upload_url
    else
      url = local_url
    end
    url
  end

  def upload_url
    src = "/upload/video/"
    src << self.play_url
  end

  def local_url
    src = "/video/"
    if self.autonym.present?
      unless self.filename.blank?
        src << self.filename
        src << "/"
      end
      src << self.autonym
    else
      src << "default.mp4"
    end
  end
end
