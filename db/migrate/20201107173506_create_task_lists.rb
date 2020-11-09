class CreateTaskLists < ActiveRecord::Migration[6.0]
  def change
    create_table :task_lists do |t|
      t.string :task_uuid
      t.string :task_sub_uuid
      t.string :hierarkey_num
      t.string :seq_num
      t.string :title
      t.text :task_memo

      t.timestamps
    end
  end
end
