class Campaign < ApplicationRecord
  belongs_to :emaillist
  belongs_to :template
  has_many :emailsends


end
