class MotionHookResponder
  attr_accessor :bot
  attr_accessor :hook

  def initialize(options = {})
    @hook = options[:hook] || OpenStruct.new(message: 'Hook called!')
    @bot = Application.settings.bot
  end

  def respond
    photos = MotionService.new.snapshot(cameras: [hook.camera])

    Subscribe.all.each do |subscribe|
      photos.each do |photo|
        PhotoSender.new(bot: bot, chat_id: subscribe.cid, photo: photo).send
      end
    end

    "Sended to #{Subscribe.all.count} subscribers"
  end
end
