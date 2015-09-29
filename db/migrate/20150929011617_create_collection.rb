class CreateCollection < ActiveRecord::Migration
  def change
    create_table :collection do |t|
      t.string :twitter_account
      t.string :image_url
      t.string :politician
      t.string :text
      t.string :date
      t.string :mood
      t.string :tsentiment

      t.timestamps
    end
  end
end
