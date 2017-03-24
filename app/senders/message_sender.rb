class MessageSender < BaseSender
  attr_reader :text

  def initialize(options)
    super(options)
    @text = options[:text]
  end

  def send
    bot.api.send_message(message)
    logger.debug "sending '#{text}' to #{chat.username}"
  end

  protected

  def message
    super.merge(text: text)
  end
end
