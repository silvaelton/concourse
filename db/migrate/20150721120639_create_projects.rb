class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :slug, unique: true
      t.string :description
      t.date :start
      t.date :end
      t.boolean :publish
      t.boolean :status
      t.string :image_header
      t.string :image_logo
      t.string :image_footer

      t.timestamps null: false
    end
  end
end
