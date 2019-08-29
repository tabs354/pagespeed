class AddDomainNameServiceIdToPagespeedInsights < ActiveRecord::Migration[5.2]
  def change
    add_column :pagespeed_insights, :domain_name_service_id, :integer, index:true
  end
end
