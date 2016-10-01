class AddSentimentAndScoreToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :sentiment, :string
    add_column :messages, :score, :decimal
  end
end
