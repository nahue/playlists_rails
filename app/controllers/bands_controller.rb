class BandsController < ApplicationController
  allow_unauthenticated_access only: [ :index ]
  before_action :set_band, only: %i[ show edit update destroy ]

  # GET /bands or /bands.json
  def index
    if authenticated?
      @bands = Current.user.bands
    else
      @bands = Band.none # Show no bands for unauthenticated users
    end
  end

  # GET /bands/1 or /bands/1.json
  def show
  end

  # GET /bands/new
  def new
    @band = Band.new
  end

  # GET /bands/1/edit
  def edit
  end

  # POST /bands or /bands.json
  def create
    @band = Band.new(band_params)
    @band.user = Current.user

    respond_to do |format|
      if @band.save
        format.html { redirect_to @band, notice: "Band was successfully created." }
        format.json { render :show, status: :created, location: @band }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bands/1 or /bands/1.json
  def update
    respond_to do |format|
      if @band.update(band_params)
        format.html { redirect_to @band, notice: "Band was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @band }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bands/1 or /bands/1.json
  def destroy
    @band.destroy!

    respond_to do |format|
      format.html { redirect_to bands_path, notice: "Band was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_band
      @band = Band.find(params.expect(:id))
      # Ensure users can only access their own bands
      if @band.user != Current.user
        redirect_to bands_path, alert: "You can only access your own bands."
      end
    end

    # Only allow a list of trusted parameters through.
    def band_params
      params.expect(band: [ :name ])
    end
end
