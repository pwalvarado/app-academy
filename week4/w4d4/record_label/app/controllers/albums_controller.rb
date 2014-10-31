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
      redirect_to @album
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @album.errors.full_messages
      @band = @album.band
      @bands = Band.all
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    @band = @album.band
    @bands = Band.all
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      redirect_to @album
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @album.errors.full_messages
      @band = @album.band
      @bands = Band.all
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @band = @album.band
    @album.destroy!
    redirect_to @band
  end

  private
  def album_params
    params.require(:album).permit(:name, :band_id, :ttype)
  end
end
