FactoryBot.define do
  factory :client, parent: :user do
    client_profile

    transient do
      coach { false }
    end

    after(:create) do |user, evaluator|
      if evaluator.coach
        create(
          :client_invitation,
          status: :completed,
          sender: evaluator.coach,
          recipient: user.client_profile
        )
      end
    end
  end
end
