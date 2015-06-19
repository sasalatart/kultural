class BetterForms < ActionView::Helpers::FormBuilder
  def title_errors
    if @object.errors.any?
      @template.content_tag(:div, id: 'error-explanation') do
        @template.content_tag(:div) do
          "This form has #{@template.pluralize(@object.errors.count, 'error')}"
        end
      end
    end
  end

  def errors(name)
    if @object.errors[name]
      @template.content_tag(:div, class: 'form-error') do
        @object.errors[name].join(', ').capitalize
      end
    end
  end
end