class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.references :user
      t.integer :project_type
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
