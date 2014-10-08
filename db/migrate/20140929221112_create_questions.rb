class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content
      t.integer :user_id
      t.integer :topic_id
      t.integer :votes

      t.timestamps
    end
  end
end
