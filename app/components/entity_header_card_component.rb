class EntityHeaderCardComponent < ViewComponent::Base
  def initialize(entity:, back_path:, icon_svg: nil, tags: [], edit_path: nil, delete_path: nil)
    @entity = entity
    @back_path = back_path
    @icon_svg = icon_svg
    @tags = tags # params like { label: "some label text", color: "bg-indigo-100 text-indigo-700" }
    @edit_path = edit_path
    @delete_path = delete_path
  end
end
