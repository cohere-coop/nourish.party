# Helper methods for markup codified in the style guide
module StyleguideHelper
  def notification(text, type: "notice", enclosing_tag: "p")
    content_tag(enclosing_tag, text, class: "notification --#{type}")
  end
end
