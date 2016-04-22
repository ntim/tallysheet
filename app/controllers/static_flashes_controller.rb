class StaticFlashesController < ApplicationController
  before_filter :authenticate
  before_action :set_static_flash, only: [:show, :edit, :update, :destroy]

  # GET /static_flashes
  # GET /static_flashes.json
  def index
    @static_flashes = StaticFlash.all
  end

  # GET /static_flashes/1
  # GET /static_flashes/1.json
  def show
  end

  # GET /static_flashes/new
  def new
    @static_flash = StaticFlash.new
  end

  # GET /static_flashes/1/edit
  def edit
  end

  # POST /static_flashes
  # POST /static_flashes.json
  def create
    @static_flash = StaticFlash.new(static_flash_params)

    respond_to do |format|
      if @static_flash.save
        format.html { redirect_to @static_flash, notice: 'Static flash was successfully created.' }
        format.json { render :show, status: :created, location: @static_flash }
      else
        format.html { render :new }
        format.json { render json: @static_flash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /static_flashes/1
  # PATCH/PUT /static_flashes/1.json
  def update
    respond_to do |format|
      if @static_flash.update(static_flash_params)
        format.html { redirect_to @static_flash, notice: 'Static flash was successfully updated.' }
        format.json { render :show, status: :ok, location: @static_flash }
      else
        format.html { render :edit }
        format.json { render json: @static_flash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /static_flashes/1
  # DELETE /static_flashes/1.json
  def destroy
    @static_flash.destroy
    respond_to do |format|
      format.html { redirect_to static_flashes_url, notice: 'Static flash was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_static_flash
      @static_flash = StaticFlash.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def static_flash_params
      params.require(:static_flash).permit(:expires, :content)
    end
end
