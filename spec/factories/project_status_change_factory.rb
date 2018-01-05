FactoryBot.define do
  factory :project_status_change do
    moderator factory: :instance_admin

    reason { "A reason" }

    factory :approval do
      reason "A reason to approve"
      action :approved
    end

    factory :rejection do
      reason "A reason to reject"
      action :rejected
    end
  end
end
