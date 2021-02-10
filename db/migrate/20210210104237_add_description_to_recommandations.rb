class AddDescriptionToRecommandations < ActiveRecord::Migration[6.0]
  def change
    add_column :recommandations, :description, :text
  end
end
