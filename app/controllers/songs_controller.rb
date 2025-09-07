class SongsController < ApplicationController
  before_action :set_band
  before_action :set_song, only: %i[ show edit update destroy ]

  # GET /bands/1/songs or /bands/1/songs.json
  def index
    @songs = @band.songs
  end

  # GET /bands/1/songs/1 or /bands/1/songs/1.json
  def show
  end

  # GET /bands/1/songs/new
  def new
    @song = @band.songs.build
  end

  # GET /bands/1/songs/1/edit
  def edit
  end

  # POST /bands/1/songs or /bands/1/songs.json
  def create
    @song = @band.songs.build(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to band_song_path(@band, @song), notice: "Song was successfully created." }
        format.json { render :show, status: :created, location: band_song_path(@band, @song) }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bands/1/songs/1 or /bands/1/songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to band_song_path(@band, @song), notice: "Song was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: band_song_path(@band, @song) }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bands/1/songs/1 or /bands/1/songs/1.json
  def destroy
    @song.destroy!

    respond_to do |format|
      format.html { redirect_to band_songs_path(@band), notice: "Song was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_band
      @band = Band.find(params.expect(:band_id))
      # Ensure users can only access their own bands
      if @band.user != Current.user
        redirect_to bands_path, alert: "You can only access your own bands."
      end
    end

    def set_song
      @song = @band.songs.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.expect(song: [ :name, :description ])
    end
end
