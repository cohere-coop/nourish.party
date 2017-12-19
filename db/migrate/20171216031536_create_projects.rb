class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :title
      t.string :summary
      t.string :status, default: "pending", null: false

      t.timestamps
    end

    create_table :project_memberships, id: :uuid do |t|
      t.uuid :member_id
      t.uuid :project_id

      t.timestamps
    end
  end
end
