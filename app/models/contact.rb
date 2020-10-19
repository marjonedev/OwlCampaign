class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :emaillist
  has_many :emailsends

  validates_presence_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
