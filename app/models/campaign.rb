class Campaign < ApplicationRecord
  belongs_to :emaillist
  belongs_to :template
  has_many :emailsends

  before_validation :set_datetime, on: [:create, :update]

  def set_datetime
    # self.datetime_send = DateTime.strptime(self.datetime_send, "%m-%d-%Y %I:%M %p")
  end

  def from
    from_name ? from_name : from_email
  end

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
