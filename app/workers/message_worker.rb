
class MessageWorker
  @queue = :system_queue

  def self.perform(message_id)
    @diary = Logger.new 'log/message.log'
    @diary.debug "request #{message_id}"

    # Task: send submission to docker service for testing and write back the testing result
    # When: after student submission
    @message = Message.find(message_id)
    MessageMailer.send_messages(@message)
  end
end

