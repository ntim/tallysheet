class TallysheetEntriesController < ApplicationController
  before_action :set_tallysheet_entry, only: [:show, :edit, :update, :destroy]
  before_action :init
  
  def init
    @consumers = Consumer.all
    @beverages = Beverage.all
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
