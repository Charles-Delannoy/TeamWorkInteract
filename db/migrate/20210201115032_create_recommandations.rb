class CreateRecommandations < ActiveRecord::Migration[6.0]
  def change
    create_table :recommandations do |t|
      t.references :axe, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
