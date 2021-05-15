class AddVideoEmbedToCoachingSessions < ActiveRecord::Migration[6.1]
  def change
    add_column :coaching_sessions,
      :video_embed,
      :string,
      comment: "Not every session will have embedded videos"
  end
end
