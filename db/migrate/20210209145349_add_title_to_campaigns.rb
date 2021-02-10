class AddTitleToCampaigns < ActiveRecord::Migration[6.0]
  def change
    add_column :campaigns, :title, :string
  end
end
