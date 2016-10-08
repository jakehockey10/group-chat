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
      when 'online' # User.appearances[:online]
        fa_icon('circle',
                text: username,
                class: 'appearance online-appearance')
      when 'away' # User.appearances[:away]
        fa_icon('sign-out',
                text: username,
                class: 'appearance away-appearance')
      when 'offline' # User.appearances[:offline]
        "#{content_tag :span, 'offline', class: 'offline'} #{username}".html_safe
      else
        return
    end
  end

end
