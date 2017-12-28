module Moderation
  # A single row in the pending project table
  class PendingProjectSection < SitePrism::Section
    element :begin_approval_button, "*[data-action=begin-approval]"
  end
end
