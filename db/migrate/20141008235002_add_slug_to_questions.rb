class AddSlugToQuestions < ActiveRecord::Migration
	add_column :questions, :slug, :string
	add_index :questions, :slug, unique: true
end
