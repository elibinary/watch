class Tag < ActiveRecord::Base

  # tags is Array
  def self.update_tags( tags )
    tags.each do |tag|
      unless Tag.find_by_name(tag)
        Tag.create(:name => tag)
      end
    end
  end
  
end
