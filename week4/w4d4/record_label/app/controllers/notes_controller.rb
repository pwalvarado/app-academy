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
end
