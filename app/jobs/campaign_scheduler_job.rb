class CampaignSchedulerJob < ApplicationJob
  queue_as :default
  discard_on ActiveJob::DeserializationError

  def perform(*args)
    # Do something later
  end
end
