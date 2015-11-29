class Admin::MonitorsController < AdminController
  before_action :set_monitor, only: [:show, :edit, :update, :destroy]

  def index
    # @admin_monitors = Admin::Monitor.all
    @used, @total = MonitorService.new.show_disk_info
  end

  # GET /admin/monitors/1
  # GET /admin/monitors/1.json
  def show
  end

  # GET /admin/monitors/new
  def new
  end

  # GET /admin/monitors/1/edit
  def edit
  end

  # POST /admin/monitors
  # POST /admin/monitors.json
  def create
  end

  # PATCH/PUT /admin/monitors/1
  # PATCH/PUT /admin/monitors/1.json
  def update
  end

  # DELETE /admin/monitors/1
  # DELETE /admin/monitors/1.json
  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_monitor
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_monitor_params
      params[:admin_monitor]
    end
end
