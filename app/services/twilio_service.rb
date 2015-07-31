class TwilioService

  ACCOUNT_SID = 'AC0f8c9805c78950d3933ea9dd6afb3460'
  AUTH_TOKEN  = '10515bd80010f0dcd070bab3739c9ee8'

  attr_accessor :client

  def initialize
    @client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
  end

  def send_sms(to, body)
    client.account.messages.create({
      :from => '+32460203580',
      :to   => '+32484580322',
      :body => 'You will die at 42 years old, sucker.',
    })
  end
end
