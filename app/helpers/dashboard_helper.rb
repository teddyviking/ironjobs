module DashboardHelper

	def select_user_dashboard
		render current_user.role
	end

	def create_notification_message(pending_things)
		kind_of_thing = pending_things.first.class.to_s.split(/(?=[A-Z])/).join(" ")

		return "#{pending_things.count} pending #{kind_of_thing} confirmation #{'request'.pluralize}"
	end
end
