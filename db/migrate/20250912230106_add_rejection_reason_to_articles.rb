class AddRejectionReasonToArticles < ActiveRecord::Migration[8.0]
  def change
    add_column :articles, :rejection_reason, :text
  end
end
