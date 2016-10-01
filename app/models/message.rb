class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  before_save :set_sentiment, if: :body_changed?

  scope :positive, -> { where(sentiment: :positive) }
  scope :neutral, -> { where(sentiment: :neutral) }
  scope :negative, -> { where(sentiment: :negative) }

  def set_sentiment
    self.sentiment = $analyzer.sentiment(body)
    self.score     = $analyzer.score(body)
  end
end
