class CampaignMailer < ApplicationMailer
  def send_campaign_email
    @from = params[:from]
    @subject = params[:to]
    @to = params[:to]
    @body = params[:body]
    mail(from: @from, to: @to, subject: @subject)
  end

  def send_test
    @body = "loremipsum dolor sit test this is a test message hello world"
    mail(to: "marjonedev@gmail.com", subject: "Send Test from Owlcampaign")
  end
end
