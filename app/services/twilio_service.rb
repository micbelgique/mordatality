class TwilioService

  NUMBER      = '+32460203580'
  ACCOUNT_SID = 'AC0f8c9805c78950d3933ea9dd6afb3460'
  AUTH_TOKEN  = '10515bd80010f0dcd070bab3739c9ee8'

  attr_accessor :client

  def initialize
    @client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
  end

  def messages_create(to, body)
    client.account.messages.create({
      :from => NUMBER,
      :to   => to,
      :body => body,
    })
  end

  def messages_list
    client.account.messages.list.collect do |m|
      {
        :sid       => m.sid,
        :date_sent => m.date_sent,
        :from      => m.from,
        :to        => m.to,
        :body      => m.body
      }
    end
  end
end
