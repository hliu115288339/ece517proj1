class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text   :body
      t.integer :user_id
      t.integer :votes
      t.references :posts

      t.timestamps
    end
  end
end
