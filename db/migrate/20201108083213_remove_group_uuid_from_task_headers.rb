class RemoveGroupUuidFromTaskHeaders < ActiveRecord::Migration[6.0]
  def change
    remove_column :task_headers, :group_uuid, :string
  end
end
