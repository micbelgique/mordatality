class Api::Twilio::MessagesController < ActionController::Base
  def index
    render :json => TwilioService.new.messages_list
  end

  def create
    sender = params[:From]
    body   = params[:Body]

    response = Twilio::TwiML::Response.new do |r|
      r.Message "You will die at 42 years old in a plane. #{body}"
    end

    render :text => response.text, :layout => false
  end
end
