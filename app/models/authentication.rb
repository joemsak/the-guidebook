class Authentication < ApplicationRecord
  belongs_to :user

  after_save_commit :sync_remote_data, if: :saved_change_to_credentials?

  private
  def sync_remote_data
    becomes("#{provider.camelize}Authentication".constantize).sync_remote_data!
  end
end
