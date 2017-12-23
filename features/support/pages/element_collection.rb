# Convenience methods for working with many elements that represent objects
class ElementCollection < SimpleDelegator
  def element_for(object)
    find do |element|
      if element.respond_to?(:id)
        element.id == object.id
      elsif element.respond_to?(:[])
        element[:"data-id"] == object.id
      elsif element.respond_to?(:root_element)
        element.root_element[:"data-id"] == object.id
      end
    end
  end

  def rendering?(*objects)
    objects.all? do |object|
      element = element_for(object)
      element.present? && element.rendering?(object)
    end
  end
end
