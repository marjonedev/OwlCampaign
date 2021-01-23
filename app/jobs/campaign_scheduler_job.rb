class CampaignSchedulerJob < ApplicationJob
  queue_as :default
  discard_on ActiveJob::DeserializationError

  def perform(campaign)
    from = "#{campaign.from_name} <#{campaign.from_email}>"
    subject = campaign.subject
    body = campaign.content
    campaign.emaillist.contacts.each do |contact|
      to = contact.email
      CampaignMailer.with(to: to, from: from, subject: subject, body: body).send_campaign_email.deliver_later
    end
  end
end
