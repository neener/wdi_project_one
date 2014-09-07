class Comment < ActiveRecord::Base

	def posts
		Post.find_by({id: self.post_id})
	end
end