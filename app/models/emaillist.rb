class Emaillist < ApplicationRecord
  belongs_to :user
  has_many :contacts

  def self.count
    self.contacts.count
  end
end
