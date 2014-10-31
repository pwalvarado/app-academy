module ApplicationHelper
  def delete_button(note)
    ("<br>" + (button_to 'Delete note', note_url(note), method: :delete)).html_safe if note.user_id == current_user.id
  end
end
