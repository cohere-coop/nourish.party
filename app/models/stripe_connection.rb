# Connection between a registered user and a payment processor
class StripeConnection < ApplicationRecord
  belongs_to :owner, class_name: "registered_user"
end
