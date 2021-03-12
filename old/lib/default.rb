# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
include Nanoc::Helpers::Blogging
include Nanoc::Helpers::Tagging
include Nanoc::Helpers::Rendering
include Nanoc::Helpers::LinkTo
def get_post_start(post)
	content = post.compiled_content
	if content =~ /\s<!-- more -->\s/
		content = content.partition('<!-- more -->').first + "<div class='read-more'><a href='#{post.path}'>Verder lezen &rsaquo;</a></div>"
	end
	return content
end
