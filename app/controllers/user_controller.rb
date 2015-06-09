class UserController < ApplicationController
  layout 'home'

  skip_before_filter :login_required

  def index
    
  end

  def signin
    puts "signin++++++++"
    if params[ :email ].present? && params[ :password ].present?
      user = User.authenticate(params[ :email ], params[ :password ])
      create_session( user )
      redirect_to :controller => '/video', :action => 'index'
      return
    end
  end

  def signout
    logout_killing_session!
    render :action => 'index'
  end

protected

  def create_session(user, remember = false)
    unless login( user )
      render :action => 'index'
      return
    end
    redirect_to :controller => '/video', :action => 'index'
    return
  end

end
