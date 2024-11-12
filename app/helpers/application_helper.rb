# app/helpers/application_helper.rb
module ApplicationHelper
  def styled_rich_text(rich_text_content, image_height: "200px", image_width: "auto")
    # Nokogiri se HTML parse karna
    doc = Nokogiri::HTML::DocumentFragment.parse(rich_text_content.to_s)
    
    # Har image tag ko search karke styling apply karna
    doc.css("img").each do |img|
      img["style"] = "height: #{image_height}; width: #{image_width};"
    end
    
    # Modified HTML ko render karna
    doc.to_html.html_safe
  end
end
