# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Tagging
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::XMLSitemap

def image_tag(url)
  "<img src='#{html_escape(url)}' alt=''/>"
end

def tagged_articles(type)
  items_with_tag(type.to_s).sort_by do |a|
    attribute_to_time(a[:sort_date])
  end.reverse
end