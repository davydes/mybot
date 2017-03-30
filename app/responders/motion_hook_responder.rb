class MotionHookResponder
  attr_accessor :bot
  attr_accessor :hook

  def initialize(options = {})
    @hook = options[:hook] || OpenStruct.new(message: 'Hook called!')
    @bot = Application.settings.bot
  end

  def respond
    Subscribe.all.each do |subscribe|
      MessageSender.new(bot: bot, chat_id: subscribe.cid, text: hook.message).send
    end
  end
end
