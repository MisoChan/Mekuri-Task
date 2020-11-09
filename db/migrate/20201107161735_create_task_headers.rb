class CreateTaskHeaders < ActiveRecord::Migration[6.0]
  def change
    create_table :task_headers do |t|
      t.string :task_uuid
      t.string :group_uuid
      t.string :title
      t.text :memo

      t.timestamps
    end
  end
end
