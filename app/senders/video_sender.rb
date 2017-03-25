class VideoSender < BaseSender
  attr_reader :video

  def initialize(options)
    super(options)
    @video = options[:video]
  end

  def send
    bot.api.send_video(message)
    logger.debug "sending '#{video}' to #{chat.username}"
  end

  protected

  def message
    options = { video: Faraday::UploadIO.new(video, 'video/avi') }
    super.merge(options)
  end
end
