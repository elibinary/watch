module Admin::VideoHelper
  def category_items
    items = Hash.new
    Video::CATEGORY_ITEMS.each do |item|
      add_item_to_hash( items, item, "/admin/video?category=#{item}" )
    end
    items
  end

  def tag_items
    items = Hash.new

    Tag.all.each do |tag|
      add_item_to_hash( items, tag.name, "/admin/video?tag=#{tag.name}" )
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
