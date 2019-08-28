class AddOverallResultColumnToPagespeedInsights < ActiveRecord::Migration[5.2]
  def change
    add_column :pagespeed_insights, :overall_results, :text
  end
end
