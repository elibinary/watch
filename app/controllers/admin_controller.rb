class AdminController < ApplicationController

  layout 'admin'

  before_filter :login_required
  before_filter :check_role

  def check_role
    @user ||= current_user
    
    return true if @user && @user.name && @user.name == "eli"
    redirect_to(:controller => '/user', :action => 'index') and return
  end
end
