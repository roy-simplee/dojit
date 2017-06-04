module ApplicationHelper
  def form_group_tag(errors)
    result = 'form-group'
    if errors.any?
      result << ' has-error'
    else
      ''
    end
  end
end
