class TemplatesController < ApplicationController
  before_action :set_template, only: [:edit, :update, :destroy]
  before_action :require_login

  # GET /templates
  # GET /templates.json
  def index
    if is_admin?
      @templates = current_user.templates.all
    else
      @templates = Template.where(admin_default: true, visible: true).or(current_user.templates.all).order(admin_default: :desc)
    end
  end

  # GET /templates/1
  # GET /templates/1.json
  def show
    @template = Template.find(params[:id])

    unless @template.admin_default
      @template = current_user.templates.find(params[:id])
    end
  end

  # GET /templates/new
  def new
    @template = current_user.templates.new
  end

  # GET /templates/1/edit
  def edit
  end

  # POST /templates
  # POST /templates.json
  def create

    @template = current_user.templates.new(template_params)

    respond_to do |format|
      if @template.save
        format.html { redirect_to templates_url, notice: 'Template was successfully created.' }
        format.json { render :show, status: :created, location: @template }
      else
        format.html { render :new }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /templates/1
  # PATCH/PUT /templates/1.json
  def update
    respond_to do |format|
      if @template.update(template_params)
        format.html { redirect_to templates_url, notice: 'Template was successfully updated.' }
        format.json { render :show, status: :ok, location: @template }
      else
        format.html { render :edit }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    @template.destroy
    respond_to do |format|
      format.html { redirect_to templates_url, notice: 'Template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def duplicate
    @template = Template.find(params[:id])
    @template = Template.duplicate(@template, current_user)

    respond_to do |format|
      if @template.save
        format.html { redirect_to edit_template_url(@template), notice: 'Template was successfully copied.' }
        format.json { render :edit, status: :created, location: @template }
      else
        format.html { redirect_to templates_url, alert: "Error copying the template" }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  def preview
    @template = Template.find(params[:id])

    unless @template.admin_default
      @template = current_user.templates.find(params[:id])
    end

    render :layout => false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = current_user.templates.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def template_params
      params.require(:template).permit(:content, :name, :visible)
    end
end
