module EmailCampaigner
  class Campaigner
    def campaign_logger
      @@campaign_logger ||= Logger.new("#{Rails.root}/log/campaigner.log")
    end
    def self.campaign_logger
      @@campaign_logger ||= Logger.new("#{Rails.root}/log/campaigner.log")
    end

    def start_checking(args = {})

    end

    def check_campaign
      # here to check the campaign every 1 minute
    end
  end
end