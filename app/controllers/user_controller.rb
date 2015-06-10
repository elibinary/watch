class UserController < ApplicationController
  layout 'home'

  skip_before_filter :login_required

  def index
    
  end

  def signin
    if params[ :email ].present? && params[ :password ].present?
      user = User.authenticate(params[ :email ], params[ :password ])

      if create_session( user )
        redirect_to(:controller => '/video', :action => 'index') and return
      else
        render :action => 'index'
        return
      end
    end
  end

  def signout
    logout_killing_session!
    render :action => 'index'
  end

protected

  def create_session(user, remember = false)
    login( user )
  end

end
