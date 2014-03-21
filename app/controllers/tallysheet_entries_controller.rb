class TallysheetEntriesController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy]
  before_action :set_tallysheet_entry, :only => [:show, :edit, :update, :destroy]
  before_action :init
  include ApplicationHelper
  
  def init
    @consumers = Consumer.order("name ASC").all
    @beverages = Beverage.order("name ASC").all
  end

  # GET /tallysheet_entries
  # GET /tallysheet_entries.json
  def index
    @tallysheet_entries = TallysheetEntry.all
  end

  # GET /tallysheet_entries/1
  # GET /tallysheet_entries/1.json
  def show
  end

  # GET /tallysheet_entries/new
  def new
    @tallysheet_entry = TallysheetEntry.new
  end

  # GET /tallysheet_entries/1/edit
  def edit
  end
  
  def new_many
    @tallysheet_entry = TallysheetEntry.new
  end
  
  def create_many
    ids = params[:tallysheet_entries][:consumer_ids]
    beverage_id = params[:tallysheet_entries][:beverage_id].to_i
    # Check if there is at least one entry.
    if ids.length < 0 || (ids.length == 1 && !numeric?(ids[1]))
      flash[:error] = 'Please select at least one consumer.'
      return redirect_to :back
    end
    # Create for each new consumer id on new tallysheet entry.
    ids.each do |id|
      if numeric?(id)
        # Create.
        entry = TallysheetEntry.new(consumer_id: id.to_i, beverage_id: beverage_id, amount: 1, payed: false)
        # Try to save.
        if !entry.save
          flash[:error] = 'Sorry, an error occured.'
          return redirect_to :back
        end
      end
    end
    # Everything successful
    flash[:notice] = 'Tallysheet entries were successfully created.'
    return redirect_to root_path
  end

  # POST /tallysheet_entries
  # POST /tallysheet_entries.json
  def create
    @tallysheet_entry = TallysheetEntry.new(tallysheet_entry_params)
    @tallysheet_entry.payed = false

    respond_to do |format|
      if @tallysheet_entry.save
        format.html { redirect_to root_path, notice: 'Tallysheet entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tallysheet_entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @tallysheet_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tallysheet_entries/1
  # PATCH/PUT /tallysheet_entries/1.json
  def update
    respond_to do |format|
      if @tallysheet_entry.update(tallysheet_entry_params)
        format.html { redirect_to @tallysheet_entry, notice: 'Tallysheet entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tallysheet_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tallysheet_entries/1
  # DELETE /tallysheet_entries/1.json
  def destroy
    @tallysheet_entry.destroy
    respond_to do |format|
      format.html { redirect_to tallysheet_entries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tallysheet_entry
      @tallysheet_entry = TallysheetEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tallysheet_entry_params
      params.require(:tallysheet_entry).permit(:consumer_id, :beverage_id, :amount, :payed)
    end
end
