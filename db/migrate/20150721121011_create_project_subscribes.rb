class CreateProjectSubscribes < ActiveRecord::Migration
  def change
    create_table :project_subscribes do |t|
      t.references :project, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.date :start
      t.date :end
      t.boolean :fee
      t.float :fee_value
      t.boolean :publish

      t.timestamps null: false
    end
  end
end
