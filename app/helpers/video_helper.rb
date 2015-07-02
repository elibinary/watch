module VideoHelper
  def video_list_by_tags
    @tag_list ||= []

    sort_videos = Hash.new
    found_videos = Hash.new
    video_arr = []

    @tag_list.each do |tag|
      Video.where("id != ? AND tags like ?", @video.id, "%#{tag}%").each do |video|
        found_videos[ video.id ] = video unless found_videos.has_key?(video.id)

        if sort_videos.has_key?(video.id)
          sort_videos[ video.id ] = sort_videos[ video.id ] + 1
        else
          sort_videos[ video.id ] = 0
        end
      end
    end

    sort_videos.sort{|a,b| b[1] <=> a[1]}.first(10).each do |arr|
      video_arr << found_videos[ arr[0] ] if found_videos.has_key?(arr[0])
    end

    return video_arr
  end

  def category_items
    items = Hash.new
    Video::CATEGORY_ITEMS.each do |item|
      add_item_to_hash( items, item, "/video?category=#{item}" )
    end
    items
  end

  def tag_items
    items = Hash.new

    Tag.all.each do |tag|
      add_item_to_hash( items, tag.name, "/video?tag=#{tag.name}" )
    end
    items
  end

  def tag_items_arr
    items = Array.new
    Tag.all.each do |tag|
      items << tag.name
    end
    items
  end

protected

  def add_item_to_hash( hash, key, value )
    hash[ key ] = value if hash.is_a? Hash
  end
end
