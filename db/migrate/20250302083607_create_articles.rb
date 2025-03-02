class CreateArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :articles do |t|
      t.string :uuid
      t.string :title
      t.string :slug
      t.text :excerpt
      t.string :feature_image
      t.datetime :published_at

      t.timestamps
    end
  end
end
