class PhotoSender
  attr_reader :photo

  def initialize(options)
    super(options)
    @photo = options[:photo]
  end

  def send
    bot.api.send_photo(message)
    logger.debug "sending '#{photo}' to #{chat.username}"
  end

  protected

  def message
    options = { photo: Faraday::UploadIO.new(photo, 'image/jpeg') }
    super.merge(options)
  end
end
