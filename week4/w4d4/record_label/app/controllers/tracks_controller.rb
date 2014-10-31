class TracksController < ApplicationController
  def show
    @track = Track.find(params[:id])
    render :show
  end

  def new
    @track = Track.new
    @album = Album.find(params[:album_id])
    @albums = Album.all
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @track.errors.full_messages
      @album = @track.album
      @albums = Album.all
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    @album = @track.album
    @albums = Album.all
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @track.errors.full_messages
      @album = @track.album
      @albums = Album.all
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @album = @track.album
    @track.destroy!
    redirect_to album_url(@album)
  end

  private
  def track_params
    params.require(:track).permit(:name, :album_id, :ttype, :lyrics)
  end
end
