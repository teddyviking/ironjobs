require 'rails_helper'

module StudentHelpers

	def respond_status_200
	  	expect(response).to be_success
		expect(response).to have_http_status(200)
  	end

end