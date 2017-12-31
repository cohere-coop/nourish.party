# A single row in the pending project table
class PendingProjectSection < SitePrism::Section
  element :begin_approval_button, "*[data-action=begin-approval]"
  element :begin_rejection_button, "*[data-action=begin-rejection]"
end
