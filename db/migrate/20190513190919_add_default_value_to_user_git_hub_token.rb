class AddDefaultValueToUserGitHubToken < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :github_token, :string, {default: nil}
    change_column :users, :github_id, :integer, {default: nil}
  end
end
