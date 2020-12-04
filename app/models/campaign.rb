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

  def date_time_send
    dt = DateTime.parse(date_send.to_s + ' ' + time_send.to_formatted_s(:time))
    dt.strftime("%d/%m/%Y %I:%M %p")
    # time_send.to_formatted_s(:time)
  end

end
