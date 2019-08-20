class DomainNameService < ApplicationRecord
  belongs_to :user
  validates :dns, presence: true, uniqueness: {case_sensitive: false}
  validates :https, inclusion: { in: [ true, false ] }
  validates :status, presence: true
end
