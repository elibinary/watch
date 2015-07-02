module HomeHelper
  
  def get_user_email
    u = User.find_by_id( session[ :user_id ] ) if session[ :user_id ]
    if u && u.email.present?
      return u.email
    end

    redirect_to :controller => '/user', :action => 'index'
  end

  def get_user_name
    u = User.find_by_id( session[ :user_id ] ) if session[ :user_id ]
    if u && u.email.present?
      return u.name
    end

    redirect_to :controller => '/user', :action => 'index'
  end

  def category_items
    items = Hash.new
    Video::CATEGORY_ITEMS.each do |item|
      add_item_to_hash( items, item, "/video?category=#{item}" )
    end
    items
  end
end