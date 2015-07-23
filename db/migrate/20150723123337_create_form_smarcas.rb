class CreateFormSmarcas < ActiveRecord::Migration
  def change
    create_table :form_smarcas do |t|
      t.string :name
      t.string :cpf
      t.string :telephone
      t.string :rg
      t.string :teste

      t.timestamps null: false
    end
  end
end
