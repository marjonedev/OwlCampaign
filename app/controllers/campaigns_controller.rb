class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  # GET /campaigns
  # GET /campaigns.json
  def index
    @campaigns = current_user.campaigns
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
  end

  # GET /campaigns/new
  def new
    @campaign = current_user.campaigns.new
    @templates = Template.where(admin_default: true, visible: true).or(current_user.templates.all).order(admin_default: :desc)
  end

  # GET /campaigns/1/edit
  def edit
    @templates = Template.where(admin_default: true, visible: true).or(current_user.templates.all).order(admin_default: :desc)
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = current_user.campaigns.new(campaign_params)

    respond_to do |format|
      if @campaign.save
        format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
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
    response_to do 'format'
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
