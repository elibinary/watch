class MonitorService
  TOTAL_SIZE = 5160    # (M)

  def show_disk_info
    size = `du -h public/upload/video | awk '{print $1}'`.to_i
    [size, MonitorService::TOTAL_SIZE]
  end
end