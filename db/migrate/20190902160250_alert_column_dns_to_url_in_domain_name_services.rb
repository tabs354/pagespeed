class AlertColumnDnsToUrlInDomainNameServices < ActiveRecord::Migration[5.2]
  def up
    rename_column :domain_name_services, :dns, :url
  end

  def down
    rename_column :domain_name_services, :url, :dns
  end
end
