module AdminHelper
  def get_user_name
    u = User.find_by_id( session[ :user_id ] ) if session[ :user_id ]
    if u && u.email.present?
      return u.name
    end

    redirect_to :controller => '/user', :action => 'index'
  end

  def admin_menu_items
    menu_items = Hash.new
    add_item_to_hash( menu_items, "Video", "/admin/video" )
    menu_items
  end

protected

  def add_item_to_hash( hash, key, value )
    hash[ key ] = value if hash.is_a? Hash
  end

end
