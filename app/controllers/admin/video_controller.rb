class Admin::VideoController < AdminController

  def index
    conditions = {}
    conditions[:category] = params[:category] if params[:category].present?
    # conditions[:category] = params[:video][:category] if params[:video].present? && params[:video][:category].present?

    filtered_apps = conditions.present? ? Video.where(conditions) : Video
    filtered_apps = filtered_apps.where("tags like ?", "%#{params[:tag]}%") if params[:tag].present?

    @videos = filtered_apps.order('id DESC').paginate :page => params[ :page ],
                         :per_page => PER_PAGE
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)

    if params[:video][:file].present?
      file = params[:video][:file]
      filename = UploadService.new.uploadfile(file)
      @video.play_url = filename
    end

    update_tags

    if @video.save
      flash[:notice] = %Q[Added video "#{@video.name}"]
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def edit
    @video = Video.find_by_id( params[ :id ] ) || Video.new
  end

  def save
    @video = Video.find_by_id( params[ :id ] )

    update_tags

    unless @video.update( video_params )
      flash[ :error ] = "Failed to save video."
      render :action => 'edit'
      return
    end
    redirect_to :action => :index
  end

  def destroy
    @video = Video.find_by_id( params[ :id ] )
    @video.destroy
    redirect_to :action => :index
  end

private

  def video_params
    params.require(:video).permit(:name, :autonym, :filename, :tags, :category)
  end

  def update_tags
    if params[ :video ][ :tags ] && params[ :video ][ :tags ].present?
      tags_arr = params[ :video ][ :tags ].split(',')
      Tag.update_tags( tags_arr )
    end
  end
end
