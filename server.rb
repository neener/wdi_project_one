require 'sinatra'
require 'sinatra/reloader'
require_relative './db/connection'
require_relative './models/gallery'
require_relative './models/post'
require_relative './models/subscriber'
require_relative './models/comment'
require 'httparty'
require 'twilio-ruby'
require_relative './db/secrets'

after do
	ActiveRecord::Base.connection.close
end

get("/") do
	erb(:index)
end

post("/galleries") do
	gallery_hash = {
		name: params["name"],
		event: params["event"],
		neighborhood: params["neighborhood"],
		address: params["address"],
		opening_date: params["opening_date"],
		open_thru: params["open_thru"]
	}

	Gallery.create(gallery_hash)

	redirect "/galleries" 
end


#galleries~~~~~~~~~~~~~~~~~~~~~~~~

get ("/galleries") do
	erb(:"galleries/index", { locals: { galleries: Gallery.all() } })
end

get ("/galleries/:id") do
	gallery = Gallery.find(params[:id])
	posts = Post.where :gallery_id => gallery.id
	erb(:"galleries/show", { locals: { gallery: gallery, posts: posts } })
end
#posts~~~~~~~~~~~~~~~~~~~~~~~~

post("/posts") do
	post = Post.create params[:post]
	gallery = Gallery.find(post.gallery_id)
	erb(:"posts/show", { locals: { gallery: gallery, post: post } })
end

get("/posts/:id") do
	post = Post.find params[:id]
	gallery = Gallery.find(post.gallery_id)
	erb(:"posts/show", { locals: { gallery: gallery, post: post } })
end
#comments~~~~~~~~~~~~~~~~~~

post("/comments") do
	client=  Twilio::REST::Client.new ACCOUNT, TOKEN
	comment= Comment.create params[:comment]
	post = Post.find(comment.post_id)
	subscribers = Subscriber.where({:post_id => post.id})
	subscribers.each do |subscriber|
		client.messages.create(
			:from => PHONE,
			:to => subscriber.phone,
			:body => comment.comment
			)
		end
	gallery = Gallery.find(post.gallery_id)
	erb(:"comments/show", { locals: { gallery: gallery, comment: comment, post: post } })
end

#subscribers~~~~~~~~~~~~~~~~~~

post("/subscribers") do
	Subscriber.create params[:subscriber]
	post = Post.find(params[:subscriber][:post_id])
	gallery = Gallery.find(post.gallery_id)
	erb(:"posts/show", { locals: { gallery: gallery, post: post } })
end
