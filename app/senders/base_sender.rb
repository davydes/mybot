class BaseSender
  attr_reader :bot
  attr_reader :chat_id
  attr_reader :answers
  attr_reader :logger

  def initialize(options)
    @bot = options[:bot]
    @chat_id = options[:chat]&.id || options[:chat_id]
    @answers = options[:answers]
    @logger = Application.config.logger
  end

  def send
    raise NotImplementedError.new("#{self.class.name} is abstract class")
  end

  protected

  def message
    message = { chat_id: chat_id }
    message.merge!(reply_markup: reply_markup) if answers
    message
  end

  private

  def reply_markup
    ReplyMarkupFormatter.new(answers).markup
  end
end
