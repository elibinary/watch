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
end
