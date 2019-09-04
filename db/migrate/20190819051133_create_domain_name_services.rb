class CreateDomainNameServices < ActiveRecord::Migration[5.2]
  def change
    create_table :domain_name_services do |t|
      t.boolean :https,   default: true
      t.string  :dns,     unique: true
      t.string  :status,  default: 'on'
      t.integer :user_id, index: true
      t.timestamps
    end
  end
end
