class NotificationController < ApplicationController
	def notify
		title = params["title"]
		text = params["text"]
		image = params["image"]
		actions = params["actions"]
		jid = params["jid"]
		msg_type = params["msg_type"]

		render json: "successful", status: 200
		

		msg = {
			jid: jid,
			msg_type: msg_type,
			title: title,
			text: text,
			image: image,
			actions: actions
		}

		msg = ActiveSupport::JSON.encode(msg)

		$redis.publish('push.new',msg)
	end
end