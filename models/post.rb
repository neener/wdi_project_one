class Post < ActiveRecord::Base

	def galleries
		Gallery.where({post_id: self.id})
	end

	def subscribers
		Subscriber.where({post_id: self.id})
	end

	def comments
		Comment.where({post_id: self.id})
	end

	def twilio(comment_id)
	end	

end