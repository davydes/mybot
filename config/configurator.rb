require 'logger'

class Configurator
  attr_reader :token, :logger

  def initialize
    setup_i18n

    @logger = Logger.new(STDOUT, Logger::DEBUG)
    @token = YAML::load(IO.read('config/secrets.yml'))['telegram_bot_token']
  end

  private

  def setup_i18n
    I18n.load_path = Dir['config/locales.yml']
    I18n.locale = :en
    I18n.backend.load_translations
  end
end
