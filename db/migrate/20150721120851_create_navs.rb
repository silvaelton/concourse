class CreateNavs < ActiveRecord::Migration
  def change
    create_table :navs do |t|
      t.references :project, index: true, foreign_key: true
      t.references :page, index: true, foreign_key: true
      t.integer :nav_type
      t.string :url
      t.integer :target
      t.integer :order
      t.boolean :publish

      t.timestamps null: false
    end
  end
end
