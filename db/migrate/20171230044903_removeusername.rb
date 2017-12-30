class Removeusername < ActiveRecord::Migration[5.1]
  def change
    remove_column :username
  end
end
