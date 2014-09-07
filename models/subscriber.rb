class Subscriber < ActiveRecord::Base

	def post
		Post.find_by({id: self.post_id})
	end

	def gallery
		Gallery.find_by({id: self.gallery_id})
	end
	
end