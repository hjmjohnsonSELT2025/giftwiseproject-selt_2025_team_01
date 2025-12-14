class FormFieldComponent < ViewComponent::Base
  def initialize(form:, field:, type: :text_field, label: nil, options: {})
    @form     = form
    @field    = field
    @type     = type
    @label    = label || field.to_s.humanize
    @options  = options
  end
end
