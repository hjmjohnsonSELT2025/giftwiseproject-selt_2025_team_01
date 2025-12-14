class EntityHeaderCardComponent < ViewComponent::Base
  def initialize(entity:, back_path:, icon_svg: nil, icon_wrapper_classes: "w-28 h-28 bg-gradient-to-br from-purple-400 to-indigo-500 rounded-3xl flex items-center justify-center mr-6 shadow-lg", tags: [], edit_path: nil, delete_path: nil)
    @entity = entity
    @back_path = back_path
    @icon_svg = icon_svg
    @icon_wrapper_classes = icon_wrapper_classes
    @tags = tags
    @edit_path = edit_path
    @delete_path = delete_path
  end
end
