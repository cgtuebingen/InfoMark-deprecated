class MessageMailer < ApplicationMailer
  default from: "noreply@info2.informatik.uni-tuebingen.de"


  def self.send_messages(message)
    @diary = Logger.new 'log/mailer.log'
    @diary.debug "request to send #{message.id}"
    User.find(message.recipients.split(",").map(&:to_i)).each do |recipient|
      @diary.debug "send to #{recipient.name}"
      send_message(recipient,message).deliver_now
    end
  end

  def send_message(recipient, message)
    mail(to: recipient.email, subject: "[InfoMark] #{message.subject}") do |format|
      format.text { message.body }
    end
  end

end
