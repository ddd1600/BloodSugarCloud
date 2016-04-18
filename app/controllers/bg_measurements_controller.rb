class BgMeasurementsController < ApplicationController
  before_action :set_bg_measurement, only: [:show, :edit, :update, :destroy]

  # GET /bg_measurements
  # GET /bg_measurements.json
  
  def import_csv
    before_count = BgMeasurement.where(:user_id => current_user.id).count
    BgMeasurement.import_csv(params[:file], current_user)
    after_count = BgMeasurement.where(:user_id => current_user.id).count
    redirect_to bg_measurements_path, :notice => "#{(after_count-before_count)} readings successfully uploaded into database"
  end
  
  def upload_csv
  end
  
  def index
    if current_user
      params[:user_id] = current_user.id
    end
      @bg_measurements = BgMeasurement.where(:user_id => params[:user_id])
#    end
  end

  # GET /bg_measurements/1
  # GET /bg_measurements/1.json
  def show
  end

  # GET /bg_measurements/new
  def new
    @bg_measurement = BgMeasurement.new
  end

  # GET /bg_measurements/1/edit
  def edit
  end

  # POST /bg_measurements
  # POST /bg_measurements.json
  def create
    x = bg_measurement_params
    x["user_id"] = current_user.id
    x["measurement_time"] = Time.now
    x["user_email_bg_timestamp"] = "#{current_user.email}_#{x['measurement_time'].to_i}"
    @bg_measurement = BgMeasurement.new(x)

    respond_to do |format|
      if @bg_measurement.save
        format.html { redirect_to @bg_measurement, notice: 'Bg measurement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bg_measurement }
      else
        format.html { render action: 'new' }
        format.json { render json: @bg_measurement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bg_measurements/1
  # PATCH/PUT /bg_measurements/1.json
  def update
    respond_to do |format|
      if @bg_measurement.update(bg_measurement_params)
        format.html { redirect_to @bg_measurement, notice: 'Bg measurement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bg_measurement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bg_measurements/1
  # DELETE /bg_measurements/1.json
  def destroy
    @bg_measurement.destroy
    respond_to do |format|
      format.html { redirect_to bg_measurements_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bg_measurement
      @bg_measurement = BgMeasurement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bg_measurement_params
      params.require(:bg_measurement).permit(:mg_dl, :notes, :patient_id)
    end
    
    def validate_csv(file)
      
    end
end
