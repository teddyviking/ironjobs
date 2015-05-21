  module ControllerHelpers
    def sign_in(user = double('user'))
      if user.nil?
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
        allow(controller).to receive(:current_user).and_return(nil)
        allow_message_expectations_on_nil
      else
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
        allow_message_expectations_on_nil
      end
    end
  end

 