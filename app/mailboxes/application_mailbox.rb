class ApplicationMailbox < ActionMailbox::Base
  # routing /something/i => :somewhere
  routing :all => :campaigners


  def mailbox_logger
    @@mailbox_logger ||= Logger.new("#{Rails.root}/log/mailbox_logger.log")
  end
  def self.mailbox_logger
    @@mailbox_logger ||= Logger.new("#{Rails.root}/log/mailbox_logger.log")
  end
end
