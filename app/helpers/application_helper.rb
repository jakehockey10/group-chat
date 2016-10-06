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

end
