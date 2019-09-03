class DomainNameService < ApplicationRecord
  belongs_to :user
  has_many :pagespeed_insights
  validates :url, presence: true, uniqueness: {case_sensitive: false}
  validates :https, inclusion: { in: [ true, false ] }
  validates :status, presence: true

  before_create :clear_prefix
  before_update :clear_prefix

  def clear_prefix
    self.url.delete_prefix! "https://"
    self.url.delete_prefix! "http://"
  end

  def set_url
    (self.https? ? "https://" : "http://") + self.url
  end
end
