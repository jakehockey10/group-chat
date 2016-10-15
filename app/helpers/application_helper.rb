module ApplicationHelper

  # Inspired by http://railscasts.com/episodes/244-gravatar?view=asciicast
  #
  # Tries to use the image a user has chosen in their settings.
  # If there isn't one there, rely on gravatar for at least their
  # default image, or if they have a gravatar set up.
  def avatar_url(object)
    if object.image_url.present?
      object.image_url(public: true)
    else
      gravatar_id = Digest::MD5::hexdigest(object.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png"
    end
  end

  def link_appearance(user)
    username = truncate(user.username, length: 20).to_str
    case user.appearance
      when 'online'
        appearance_icon 'circle', username, 'online'
      when 'away'
        appearance_icon 'sign-out', username, 'away'
      when 'offline'
        appearance_icon 'circle-thin', username, 'offline'
      else
        appearance_icon 'question-circle-o', username
    end
  end

  def unread_messages_badge(chatroom)
    last_read_at    = ChatroomUser.find_by(user: current_user, chatroom: chatroom).last_read_at
    unread_messages = chatroom.messages.where('created_at > ?', last_read_at)
    if unread_messages.any?
      content_tag :span, unread_messages.count, class: 'badge pull-right'
    end
  end

  def active_class(path)
    current_page?(path) ? 'active' : ''
  end

  private

  def appearance_icon(icon_name, text = '', class_name = '')
    fa_icon(icon_name,
            { text:  text,
              class: class_name.empty? ?
                         'appearance' :
                         "appearance #{class_name}-appearance" })
  end

end
