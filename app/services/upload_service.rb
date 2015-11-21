class UploadService
  def uploadfile(file)
    if !file.original_filename.empty?
      @filename = generate_filename
      # @type = File.extname(file)
      #设置目录路径，如果目录不存在，生成新目录
      FileUtils.mkdir("#{Rails.root}/public/upload") unless File.exist?("#{Rails.root}/public/upload")
      FileUtils.mkdir("#{Rails.root}/public/upload/video") unless File.exist?("#{Rails.root}/public/upload/video")
      #写入文件      
      ##wb 表示通过二进制方式写，可以保证文件不损坏
      File.open("#{Rails.root}/public/upload/video/#{@filename}", "wb") do |f|
        f.write(file.read)
      end
      return @filename
    end
  end

  def generate_filename
    t = Time.now
    t.strftime('%Y%m%d%H%M%S') + t.nsec.to_s
  end
end