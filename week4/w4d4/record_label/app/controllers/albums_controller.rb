class AlbumsController < ApplicationController
  def show
    @album = Album.find(params[:id])
    render :show
  end

  def new
    @album = Album.new
    @band = Band.find(params[:band_id])
    @bands = Band.all
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @album.errors.full_messages
      @band = Band.find(@album.band_id)
      @bands = Band.all
      render :new
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @band = @album.band
    @album.destroy!
    redirect_to band_url(@band)
  end

  private
  def album_params
    params.require(:album).permit(:name, :band_id, :ttype)
  end
end
