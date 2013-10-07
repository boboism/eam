class AddDepartmentIdAndCostCenterIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :department_id, :integer
    add_column :usres, :cost_center_id, :integer
  end
end
