class VideoController < ApplicationController
  layout 'home'

  before_filter :video_required, :only => [ :show ]

  def index
    conditions = {}
    # conditions[:id] = params[:app_default][:id] if params[:app_default].present? && params[:app_default][:id].present?

    filtered_apps = conditions.present? ? Video.where(conditions) : Video

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
  end

protected
  
  def video_required
    @video
    @video ||= Video.find_by_id( params[ :id ] ) if params[ :id ].present?
    render_api_error( :message => 'Unknown video' ) unless @video
  end

end
