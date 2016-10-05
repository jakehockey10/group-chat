module ApplicationHelper

  # http://railscasts.com/episodes/244-gravatar?view=asciicast
  def avatar_url(object)
    if object.image_url.present?
      object.image_url
    else
      gravatar_id = Digest::MD5::hexdigest(object.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png"
    end
  end

end
