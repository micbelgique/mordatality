class Api::Twilio::MessagesController < ActionController::Base
  def create
    sender = params[:From]

    response = Twilio::TwiML::Response.new do |r|
      r.Message "You will die at 42 years old in a plane."
    end

    render :text => response.text, :layout => false
  end
end
