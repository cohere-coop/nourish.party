class CreateModeratorActions < ActiveRecord::Migration[5.1]
  def change
    create_table :moderator_actions, id: :uuid do |t|
      t.string :action
      t.string :reason
      t.references :moderator, type: :uuid, index: true
      t.references :object, type: :uuid, index: true
      t.string :object_type
      t.timestamps
    end
  end
end
