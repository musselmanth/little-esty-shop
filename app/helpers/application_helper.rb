module ApplicationHelper
  def price_convert(integer_price)
    number_to_currency(integer_price / 100.to_d)
  end

  def percent_convert(decimal_percent)
    "#{(decimal_percent * 100).to_i}%"
  end

  # Convert markdown to HTML
  # def markdown(text)
  #   options = {
  #     filter_html:     true,
  #     hard_wrap:       true, 
  #     link_attributes: { rel: 'nofollow', target: "_blank" },
  #     space_after_headers: true, 
  #     fenced_code_blocks: true
  #   }

  #   extensions = {
  #     autolink:           true,
  #     superscript:        true,
  #     disable_indented_code_blocks: true
  #   }

  #   renderer    = Redcarpet::Render::HTML.new(options)
  #   @markdown ||= Redcarpet::Markdown.new(renderer, extensions)
  #   @markdown.render(text).html_safe
  # end    
end

