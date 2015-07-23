class CreateCandidateSubscribes < ActiveRecord::Migration
  def change
    create_table :candidate_subscribes do |t|

      t.references :user, index: true
      t.references :project_subscribe, index: true
      t.integer    :form_id, index: true
      t.string     :form_type, index: true
      t.integer    :status, default: 0
      
      t.timestamps null: false
    end
  end
end
