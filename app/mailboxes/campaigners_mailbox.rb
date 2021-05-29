class CampaignersMailbox < ApplicationMailbox

  def process
    self.mailbox_logger.debug mail.subject
    self.mailbox_logger.debug mail.decoded
    byebug
  end

end
