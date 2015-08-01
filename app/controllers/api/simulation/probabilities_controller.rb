class Api::Twilio::ProbabilitiesController < ActionController::Base
  def index
    render :json => nil #TwilioService.new.messages_list
  end
end
