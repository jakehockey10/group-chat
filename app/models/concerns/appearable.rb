module Appearable
  extend ActiveSupport::Concern

  included do
    enum appearance: {
        online:  1,
        away:    2,
        offline: 0
    }
  end

  def appear
    self.online!
  end

  def disappear
    self.offline!
  end

  def away
    self.away!
  end

end