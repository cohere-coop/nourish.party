class CreateProjectStatusChanges < ActiveRecord::Migration[5.1]
  def change
    create_table :project_status_changes, id: :uuid do |t|
      t.string :action
      t.string :reason
      t.references :moderator, type: :uuid, index: true
      t.references :project, type: :uuid, index: true
      t.timestamps
    end
  end
end
