=begin
  Campaign Status
  1. incomplete
  2. pending
  3. sent
=end
class Campaign < ApplicationRecord
  belongs_to :emaillist, optional: true
  belongs_to :template, optional: true
  belongs_to :user
  has_many :emailsends
  belongs_to :from_email, optional: true

  before_validation :set_datetime, on: [:create, :update]
  # after_commit :send_campaign_job, on: :create
  after_create :send_campaign_job
  before_create :set_from_email
  before_update :set_from_email

  def set_datetime
    # self.datetime_send = DateTime.strptime(self.datetime_send, "%m-%d-%Y %I:%M %p")
  end

  def from
    from_name ? from_name : from_email
  end

  def duplicate
    cmp = self.dup
    cmp.subject = self.subject + "(1)"
    cmp.status = 'incomplete'
    cmp.datetime_send = nil
    cmp.instant = nil
    cmp.status = "incomplete"

    cmp
  end

  def datetime_send_str
    begin
      dt = DateTime.parse(datetime_send.to_s)
      dt.strftime("%d/%m/%Y %I:%M %p")
    rescue => e
      nil
    end
  end

  def send_now
    from = "#{self.from_name} <#{self.from_email}>"
    subject = self.subject
    body = self.content
    emaillist.contacts.each do |contact|
      to = contact.email
      print(to)
      mail = CampaignMailer.with(to: to, from: from, subject: subject, body: body).send_campaign_email().deliver_now
    end
  end

  def self.test_send(who)
    #to = "marjone@owlreply.com"
    to = "kopf1988@gmail.com"
    to = who
    from = "Marjone <marjonedev@gmail.com>"
    subject = "Test Send from Owlcampaign"
    body = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec iaculis sem turpis, non placerat diam suscipit eu. Suspendisse metus purus, gravida eu mi vel, eleifend euismod nunc."
    CampaignMailer.with(to: to, from: from, subject: subject, body: body).send_campaign_email.deliver_now
  end

  def send_campaign_job
    # CampaignSchedulerJob.set(wait: self.datetime_send).perform_later(self)
  end

  def content_full
    content = self.content ? self.content.to_s : ''
    if self.template
      self.template.content.to_s.gsub("%%content%%", content)
    else
      ''
    end
    # self.template.content
  end

=begin
  1.1. Email Subject
  1.2. From
    2.1. Template
    3.1 Content
      4.1 Email List
      4.2 Date
=end
  def get_step
    unless self.subject
      return "step1"
    end
    unless self.from_name
      return "step1"
    end
    unless self.from_email_id
      return "step1"
    end
    unless self.template
      return "step2"
    end
    unless self.content
      return "step3"
    end
    unless self.emaillist_id
      return "step4"
    end
    unless self.datetime_send
      return "step4"
    end

    "complete"
  end

  private
  def set_from_email
    self.from_email_address = FromEmail.find(self.from_email_id).email_address
  end

end
