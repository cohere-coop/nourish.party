class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :title
      t.string :summary
      t.uuid :from_project_request_id

      t.timestamps
    end

    create_table :projects_users, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :project_id

      t.timestamps
    end

    create_table :project_requests, id: :uuid do |t|
      t.string :title
      t.string :summary
      t.string :status

      t.timestamps
    end

    create_table :project_requests_users, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :project_request_id

      t.timestamps
    end
  end
end
