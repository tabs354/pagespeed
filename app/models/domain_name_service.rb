class DomainNameService < ApplicationRecord
  belongs_to :user
  validates :dns, presence: true, uniqueness: {case_sensitive: false}
  validates :https, inclusion: { in: [ true, false ] }
  validates :status, presence: true

  before_create :clear_prefix
  before_update :clear_prefix

  def clear_prefix
    self.dns.delete_prefix! "https://"
    self.dns.delete_prefix! "http://"
  end
end
