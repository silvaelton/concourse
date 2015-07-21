class CreateCandidateSubscribes < ActiveRecord::Migration
  def change
    create_table :candidate_subscribes do |t|

      t.timestamps null: false
    end
  end
end
