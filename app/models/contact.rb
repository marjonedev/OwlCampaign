class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :emaillist
  has_many :emailsend
end
