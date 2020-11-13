class Campaign < ApplicationRecord
  belongs_to :emaillist
  belongs_to :template
  has_many :emailsends

  def duplicate
    cmp = self.dup
    cmp.name = self.name + "(1)"
    cmp.status = 'draft'
    cmp.date_send = nil
    cmp.time_send = nil
    cmp.instant = nil

    cmp
  end

end
