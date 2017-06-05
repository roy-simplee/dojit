class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  default_scope { order('created_at DESC') }

  validates :body, length: { minimum: 5 }, presence: true
  # validates :topic, presence: true
  validates :post, presence: true
  validates :user, presence: true

  def markdown_body
    render_as_markdown body
  end

  private
  def render_as_markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end
end
