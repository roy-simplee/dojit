module ApplicationHelper
  def form_group_tag(errors)
    result = 'form-group'
    if errors.any?
      result << ' has-error'
    else
      ''
    end
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end
end
