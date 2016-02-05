class BeveragesController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy]
  before_action :set_beverage, :only => [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction, :sort_numeric_column
  # GET /beverages
  # GET /beverages.json
  
  def index
    @beverages = Beverage.all
  end

  def prices
    if sort_numeric_column != nil
      @beverages = Beverage.all()
      method_name = sort_numeric_column
      dir = sort_direction_numeric
      @beverages = @beverages.sort_by{|e| dir * e.send(method_name)}
    else
      @beverages = Beverage.order(sort_column + " " + sort_direction).load()
    end
    total = TallysheetEntry.sum(:amount) * 1.0
    @quota = Hash.new
    @beverages.each do |b|
      puts TallysheetEntry.where(beverage: b).sum(:amount)
      @quota[b] = TallysheetEntry.where(beverage: b).sum(:amount) / total
    end
  end

  # GET /beverages/1
  # GET /beverages/1.json
  def show
  end

  # GET /beverages/new
  def new
    @beverage = Beverage.new
  end

  # GET /beverages/1/edit
  def edit
  end

  # POST /beverages
  # POST /beverages.json
  def create
    @beverage = Beverage.new(beverage_params)

    respond_to do |format|
      if @beverage.save
        format.html { redirect_to @beverage, notice: 'Beverage was successfully created.' }
        format.json { render action: 'show', status: :created, location: @beverage }
      else
        format.html { render action: 'new' }
        format.json { render json: @beverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beverages/1
  # PATCH/PUT /beverages/1.json
  def update
    respond_to do |format|
      if @beverage.update(beverage_params)
        format.html { redirect_to @beverage, notice: 'Beverage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @beverage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beverages/1
  # DELETE /beverages/1.json
  def destroy
    @beverage.destroy
    respond_to do |format|
      format.html { redirect_to beverages_url }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_beverage
    @beverage = Beverage.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def beverage_params
    params.require(:beverage).permit(:name, :price, :available)
  end

  def sort_column
    Beverage.column_names.include?(params[:sort]) ? params[:sort] : params[:sort_numeric] != nil ? "" : "name"
  end

  def sort_numeric_column
    params[:sort_numeric] != nil && Beverage.new.respond_to?(params[:sort_numeric]) ? params[:sort_numeric] : nil
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_direction_numeric
    params[:direction] == "asc" ? 1 : -1
  end
end
