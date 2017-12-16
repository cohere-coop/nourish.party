class HomePage < SitePrism::Page
  set_url "/"

  elements :parties, ".party"

  def has_party?(title:)
    parties.any? do |party|
      party.find(".title").text == title
    end
  end
end
