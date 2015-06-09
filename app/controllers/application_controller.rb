class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include AuthenticatedSystem

  HTTP_STATUS_ERROR = 400
  ERROR_UNIMPLEMENTED = 1000
  PER_PAGE = 10

  before_filter :login_required

  def render_api_error( args = {} )
    info = { :message => 'Unimplemented', :status => HTTP_STATUS_ERROR, :code => ERROR_UNIMPLEMENTED }.merge( args )
    json_hash =  { :error => true, :message => info[ :message ], :code => info[ :code ] }
    render :json => json_hash, :status => info[ :status ]
  end

  def login( user, remember = false )
    reset_cookie_session!

    if user
      self.current_user = user
      remember_flag = remember || (params[ :remember_me ] == "1")
      handle_remember_cookie( remember_flag )
    else
      @email = params[ :email ]
      @remember = params[ :remember_me ]
      return false
    end
  end
end
