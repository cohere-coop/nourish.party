# Encapsulates what a contribution looks like on the website
class ContributionSection < SitePrism::Section
  def displaying?(contribution)
    root_element.has_text?(contribution.amount.format(symbol: true)) &&
      root_element.has_text?(contribution.created_at) &&
      root_element.has_text?(contribution.project_title)
  end
end
