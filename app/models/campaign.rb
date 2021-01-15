class Campaign < ApplicationRecord
  belongs_to :emaillist
  belongs_to :template
  belongs_to :user
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

  def send_campaign
    from = "#{self.from_name} <#{self.from_email}>"
    subject = self.subject
    body = self.content
    emaillist.contacts.each do |contact|
      to = contact.email
      print(to)
      mail = CampaignMailer.with(to: to, from: from, subject: subject, body: body).send_campaign_email().deliver_now
    end
  end

  def self.test_send
    to = "marjone@owlreply.com"
    from = "Marjone <marjonedev@gmail.com>"
    subject = "Test Send from Owlcampaign"
    body = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec iaculis sem turpis, non placerat diam suscipit eu. Suspendisse metus purus, gravida eu mi vel, eleifend euismod nunc."
    CampaignMailer.with(to: to, from: from, subject: subject, body: body).send_campaign_email.deliver_now
  end

end
