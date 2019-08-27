class PagespeedInsight < ApplicationRecord
  serialize :field_paint, JSON
  serialize :field_input, JSON
  serialize :origin_paint, JSON
  serialize :origin_input, JSON
  serialize :lighthouse_result, JSON

  belongs_to :domain_name_service
end
