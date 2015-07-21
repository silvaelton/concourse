class CreateProjectParticipations < ActiveRecord::Migration
  def change
    create_table :project_participations do |t|
      t.string :title
      t.references :project, index: true, foreign_key: true
      t.references :project_subscribe, index: true, foreign_key: true
      t.integer :form_id
      t.references :form, index: true, foreign_key: true
      t.integer :form_code
      t.boolean :publish

      t.timestamps null: false
    end
  end
end
