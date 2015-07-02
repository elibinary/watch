class VideoController < ApplicationController
  layout 'home'

  before_filter :video_required, :only => [ :show, :add_tag ]

  def index
    conditions = {}
    conditions[:category] = params[:category] if params[:category].present?
    # conditions[:id] = params[:app_default][:id] if params[:app_default].present? && params[:app_default][:id].present?

    filtered_apps = conditions.present? ? Video.where(conditions) : Video
    filtered_apps = filtered_apps.where("tags like ?", "%#{params[:tag]}%") if params[:tag].present?

    @videos = filtered_apps.order('id DESC').paginate :page => params[ :page ],
                         :per_page => PER_PAGE
  end

  def show
    @src = "/video/"
    if @video.autonym.present?
      unless @video.filename.blank?
        @src << @video.filename
        @src << "/"
      end
      @src << @video.autonym
    else
      @src << "default.mp4"
    end
    @tag_list = @video.tag_list
  end

  def add_tag
    if params[ :tags ] && params[ :tags ].present?
      # step 1
      tags_arr = params[ :tags ].split(',')
      Tag.update_tags( tags_arr )
      # step 2
      tags_str = @video.tags || ""
      tags_str = tags_str.clone

      tags_list = @video.tag_list
      tags_arr.each do |tag|
        tags_str << "," unless tags_str == ""
        tags_str << tag unless tags_list.include?(tag)
      end

      @video.tags = tags_str
      
      @video.save
    end
    # @tag_list = @video.tag_list
    redirect_to :action => 'show', :id => @video 
  end

protected
  
  def video_required
    @video = Video.find_by_id( params[ :id ] ) if params[ :id ].present?
    render_api_error( :message => 'Unknown video' ) unless @video
  end

end
