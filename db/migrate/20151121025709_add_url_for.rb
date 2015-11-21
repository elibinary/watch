class AddUrlFor < ActiveRecord::Migration
  def change
    add_column :videos, :play_url, :string
  end
end
