class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :project, index: true, foreign_key: true
      t.string :title
      t.string :slug, unique: true
      t.text :content
      t.boolean :publish

      t.timestamps null: false
    end
  end
end
