class Gallery < ActiveRecord::Base
	
	def subscribers
		Subscriber.where({gallery_id: self.id})
	end

	def posts
		Post.where({post_id: self.id})
	end
end