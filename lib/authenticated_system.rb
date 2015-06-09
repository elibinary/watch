module AuthenticatedSystem
  
  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= (login_from_session || login_from_cookie)
  end

  def current_user=(user)
    session[ :user_id ] = user.id
    @current_user = user || false
  end

  # Filter method to enforce a login requirement.
  def login_required
    puts "This is login_required"
    if logged_in?
      return true
    else
      redirect_to :controller => '/user', :action => 'index'
      return
    end
  end

  #####################################################################
  ## Login from XXX
  ## Author Eli
  #####################################################################
  def login_from_session
    self.current_user = User.find_by_id( session[ :user_id ] ) if session[ :user_id ]
  end

  def login_from_cookie
    u = User.find_by_remember_token( cookies[ :auth_token ] ) if cookies[ :auth_token ]
    if u && u.remember_token.present?
      self.current_user = u
      set_remember_cookie!
      self.current_user
    end
  end


  def handle_remember_cookie( remember_flag )
    return unless @current_user

    @current_user.refresh_token if valid_remember_cookie
    if remember_flag
      @current_user.remember_me_until 
    else
      @current_user.forget_me
    end
    
    set_remember_cookie!
  end

  def valid_remember_cookie
    return nil unless @current_user
    @current_user.remember_token.present? && (cookies[ :auth_token ] == @current_user.remember_token)
  end

  def reset_cookie_session!
    # Kill server-side auth cookie
    @current_user.forget_me if @current_user.is_a? User

    kill_remember_cookie!     # Kill client-side auth cookie
    session[:user_id] = nil   # keeps the session but kill our variable
  end

  def logout_killing_session!
    reset_cookie_session!
    reset_session
  end

  def kill_remember_cookie!
    cookies.delete :auth_token
  end

  def set_remember_cookie!
    cookies[ :auth_token ] = {
      :value => @current_user.remember_token,
      :expires => @current_user.remember_token_expires_at || 30.minute.from_now
    }
  end


  # Inclusion hook to make #current_user and #logged_in?
  # available as ActionView helper methods.
  def self.included(base)
    base.send :helper_method, :current_user, :logged_in? if base.respond_to? :helper_method
  end

  # module ClassMethods
    
  # end
  
  # module InstanceMethods
    
  # end
  
  # def self.included(receiver)
  #   receiver.extend         ClassMethods
  #   receiver.send :include, InstanceMethods
  # end
end