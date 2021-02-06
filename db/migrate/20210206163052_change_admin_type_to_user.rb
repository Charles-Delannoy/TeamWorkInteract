class ChangeAdminTypeToUser < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.change :admin, :string
    end
  end
end
