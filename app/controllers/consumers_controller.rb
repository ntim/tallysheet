class ConsumersController < ApplicationController
  before_filter :authenticate, :only => [:create, :mail_debt_remainder, :pay, :edit, :update, :destroy, :transfer, :update_derived]
  before_action :set_consumer, :only => [:show, :edit, :update, :destroy, :history, :payments, :mail_debt_remainder, :transfer, :pay]
  include ApplicationHelper

  # GET /consumers
  # GET /consumers.json
  def index
    @consumers = Consumer.all
  end
  
  def pay
    if params[:amount] != nil
      if numeric?(params[:amount])
        @consumer.pay params[:amount].to_f
        flash[:notice] = "Successfully payed #{params[:amount]} &euro;."
        redirect_to @consumer
      else
        flash[:error] = "Amount has to be numeric."
      end
    end
  end
  
  def transfer
    @recipients = Consumer.where("id != #{params[:consumer_id]}").order("name ASC").all
    if params[:amount] != nil
      if numeric?(params[:amount])
        recipient = Consumer.find(params[:recipient_id])
        @consumer.transfer recipient, params[:amount].to_f
        flash[:notice] = "Successfully transferred #{params[:amount]} &euro; to #{recipient.name}."
        redirect_to @consumer
      else
        flash[:error] = "Amount has to be numeric."
      end
    end
  end
  
  def mail_debt_remainder
    ConsumersMailer.debt_reminder(@consumer).deliver
    flash[:notice] = "Delivered reminder email to %s." % @consumer.name
    redirect_to :back
  end
  
  def history
    @tallysheet_entries = TallysheetEntry.where(:consumer => @consumer).paginate(:page => params[:page], :per_page => 12)
  end

  def payments
  	@payments = Payment.where(consumer: @consumer).paginate(:page => params[:page], :per_page => 12)
  end


  # GET /consumers/1
  # GET /consumers/1.json
  def show
    total = TallysheetEntry.where(consumer: @consumer).sum(:amount) * 1.0
    @quota = Hash.new
    Beverage.all.each do |b|
      if total > 0
      	@quota[b] = TallysheetEntry.where(consumer: @consumer, beverage: b).sum(:amount) / total
      else
      	@quota[b] = 0
      end
    end
  end

  # GET /consumers/new
  def new
    @consumer = Consumer.new
  end

  # GET /consumers/1/edit
  def edit
  end

  # POST /consumers
  # POST /consumers.json
  def create
    @consumer = Consumer.new(consumer_params)

    respond_to do |format|
      if @consumer.save
        format.html { redirect_to @consumer, notice: 'Consumer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @consumer }
      else
        format.html { render action: 'new' }
        format.json { render json: @consumer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /consumers/1
  # PATCH/PUT /consumers/1.json
  def update
    respond_to do |format|
      if @consumer.update(consumer_params)
        format.html { redirect_to @consumer, notice: 'Consumer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @consumer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consumers/1
  # DELETE /consumers/1.json
  def destroy
    @consumer.destroy
    respond_to do |format|
      format.html { redirect_to consumers_url }
      format.json { head :no_content }
    end
  end
  
  # GET /consumers/update_derived
  def update_derived
    consumers = Consumer.all
    for c in consumers
      c.update_derived
    end
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Updated derived attributes of all customers' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_consumer
      if params.has_key? :consumer_id
      	@consumer = Consumer.find(params[:consumer_id])
      else
        @consumer = Consumer.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def consumer_params
      params.require(:consumer).permit(:name, :email, :credit, :visible)
    end
end
