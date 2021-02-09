class CreateTableIcons < ActiveRecord::Migration[6.0]
  def change
    create_table :table_icons do |t|
      t.string :code
      t.string :name
      t.string :family
    end
  end
end
