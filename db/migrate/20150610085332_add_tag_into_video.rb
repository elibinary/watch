class AddTagIntoVideo < ActiveRecord::Migration
  def change
    add_column :videos, :tags, :string
    add_column :videos, :category, :string
  end
end
