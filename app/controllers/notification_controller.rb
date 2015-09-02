class NotificationController < ApplicationController
	def notify
		title = params["title"]
		text = params["text"]
		image = params["image"]
		actions = params["actions"]
		jid = params["jid"],
		type = params["type"]

		render json: "successful", status: 200
		

		msg = {
			type: type,
			jid: jid,
			title: title,
			text: text,
			image: image,
			actions: actions
		}

		msg = ActiveSupport::JSON.encode(msg)

		$redis.publish('push.new',msg)
	end
end