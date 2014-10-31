class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.track_id = params[:track_id]
    if !@note.save
      flash[:errors] ||= []
      flash[:errors] += @note.errors.full_messages
    end
    redirect_to track_url(params[:track_id])
  end

  def note_params
    params.require(:note).permit(:body)
  end

  def destroy
    @note = Note.find(params[:id])
    if !(current_user.id == @note.user_id)
      render text: "That's not your note, jerk.", status: :forbidden
    else
      @track = @note.track
      @note.destroy!
      redirect_to @track
    end
  end
end
