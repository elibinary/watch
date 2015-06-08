class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  HTTP_STATUS_ERROR = 400
  ERROR_UNIMPLEMENTED = 1000
  PER_PAGE = 10

  def render_api_error( args = {} )
    info = { :message => 'Unimplemented', :status => HTTP_STATUS_ERROR, :code => ERROR_UNIMPLEMENTED }.merge( args )
    json_hash =  { :error => true, :message => info[ :message ], :code => info[ :code ] }
    render :json => json_hash, :status => info[ :status ]
  end
end
