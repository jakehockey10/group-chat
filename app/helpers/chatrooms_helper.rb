module ChatroomsHelper
  def sent_at_for(message)
    local_relative_time(message.created_at, type: 'time-or-date')
  end
end
