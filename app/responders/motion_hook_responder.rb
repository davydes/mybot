class MotionHookResponder
  attr_accessor :bot

  def initialize
    @bot = Application.settings.bot
  end

  def respond
    Subscribe.all.each do |subscribe|
      MessageSender.new(bot: bot, chat_id: subscribe.cid, text: 'Hook called!').send
    end
  end
end
