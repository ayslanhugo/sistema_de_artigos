class AddRejectionSeenToArticles < ActiveRecord::Migration[8.0]
  def change
    add_column :articles, :rejection_seen, :boolean
    add_column :articles, :default, :string
    add_column :articles, :false, :string
  end
end
