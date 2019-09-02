class RecreatePagespeedInsights < ActiveRecord::Migration[5.2]
  def change
    create_table "pagespeed_insights" do |t|
      t.text    :field_paint
      t.text    :field_input
      t.text    :origin_paint
      t.text    :origin_input
      t.text    :lighthouse_result
      t.integer :domain_name_service_id
      t.text    :overall_results
      t.timestamp
    end
  end
end
