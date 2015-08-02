class Api::Twilio::MessagesController < ActionController::Base
  def index
    render :json => TwilioService.new.messages_list
  end

  def create
    failed = false
    sender = params[:From]
    body   = params[:Body].to_s.strip.split(' ')

    if body.size == 3
      date_of_birth = Date.civil(Date.today.year - body[0].to_i, 1, 1)
      gender        = body[1].upcase == 'H' ? 'M' : 'F'
      zip           = body[2]
      province_id = Province.find_by_zip_code(zip).id
    else
      failed = true
    end

    if failed
      response = Twilio::TwiML::Response.new do |r|
        r.Message "Message mal formaté. Exemples : \"28 h 7000\" ou \"34 f 1020\"."
      end
    else
      estimation = EstimationService.new(
        date_of_birth,
        gender,
        province_id
      ).estimate

      response = Twilio::TwiML::Response.new do |r|
        r.Message "Si nos calculs sont exacts, vous devriez mourir à #{estimation[:age]} ans."
      end
    end

    render :text => response.text, :layout => false
  end

  def new
    create
  end
end
