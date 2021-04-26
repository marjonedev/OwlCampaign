class CampaignsController < ApplicationController

  before_action :set_campaign, only: [:show, :edit, :update, :destroy, :campaign_subject, :choose_template, :write_content, :schedule_email]
  before_action :require_login

  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = current_user.campaigns.order("id DESC")
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
  end

  # GET /campaigns/new
  def new
    @campaign = current_user.campaigns.new
  end

  # GET /campaigns/1/edit
  def edit

    @step = @campaign.get_step
    if @step == "step2"
      redirect_to action: :choose_template, controller: :campaigns, id: @campaign.id
    elsif @step == "step3"
      redirect_to action: :write_content, controller: :campaigns, id: @campaign.id
    elsif @step == "step4"
      redirect_to action: :schedule_email, controller: :campaigns, id: @campaign.id
    end

    @templates = Template.where(admin_default: true, visible: true).or(current_user.templates.all).order(admin_default: :desc)

  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = current_user.campaigns.new(campaign_params)

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to action: :choose_template, controller: :campaigns, id: @campaign.id }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def campaign_subject
    if request.patch?
      respond_to do |format|
        if @campaign.update(campaign_params)
          format.html { redirect_to choose_template_campaign_url(@campaign) }
          format.json { render :show, status: :ok, location: @campaign }
        end
      end
    else

    end
  end

  def choose_template
    if request.patch?
      respond_to do |format|
        if @campaign.update(campaign_params)
          format.html { redirect_to action: :write_content, controller: :campaigns, id: @campaign.id }
          format.json { render :show, status: :ok, location: @campaign }
        else
          format.html { render :edit }
          format.json { render json: @campaign.errors, status: :unprocessable_entity }
        end
      end
    else
      @templates = Template.where(admin_default: true, visible: true).or(current_user.templates.all).order(admin_default: :desc)
      # Show the page to let them choose the template.
    end
  end

  def write_content
    if request.patch?
      respond_to do |format|
        if @campaign.update(campaign_params)
          format.html { redirect_to action: :schedule_email, controller: :campaigns, id: @campaign.id }
          format.json { render :show, status: :ok, location: @campaign }
        else
          format.html { render :edit }
          format.json { render json: @campaign.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def schedule_email
    if request.patch?
      respond_to do |format|
        if @campaign.update(campaign_params)
          #todo: check first if all completed
          @campaign.update_attribute(:status, 'scheduled')
          format.html { redirect_to :campaigns, notice: 'Success. Campaign was successfully scheduled.' }
          format.json { render :show, status: :ok, location: @campaign }
        else
          format.html { render :edit }
          format.json { render json: @campaign.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to campaigns_url, notice: 'Campaign was successfully updated.' }
        # format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' + campaign_params["datetime_send"] }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_send
    response_to do |format|
      if @campaign.update(campaign_params)
        @campaign.send
        format.html { redirect_to campaigns_url, notice: 'Campaign was successfully updated and added to queue for sending.' }
        format.json { render :show, status: :ok, location: campaigns_url }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def duplicate
    @campaign = Campaign.find(params[:id])
    @campaign = @campaign.duplicate

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to edit_campaign_url(@campaign), notice: 'Campaign was successfully copied.' }
        format.json { render :edit, status: :created, location: @campaign }
      else
        format.html { redirect_to campaigns_url, alert: "Error copying the campaign" }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  def preview
    @campaign = current_user.campaigns.find(params[:id])
    render :layout => false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def campaign_params
      params.require(:campaign).permit(:emaillist_id, :template_id, :name, :from_name, :from_email, :subject, :content, :datetime_send)
    end
end
