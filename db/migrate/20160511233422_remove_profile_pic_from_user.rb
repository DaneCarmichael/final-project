class RemoveProfilePicFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :profile_pic
  end
end
