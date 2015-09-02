class NotificationController < ApplicationController
	def notify
		title = params["title"]
		text = params["text"]
		image = params["image"]
		actions = params["actions"]
		jid = params["jid"],
		msg_type = params["msg_type"]

		render json: "successful", status: 200
		

		msg = {
			msg_type: msg_type,
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