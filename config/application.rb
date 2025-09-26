require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module SistemaDeArtigos
  class Application < Rails::Application
    config.load_defaults 8.0
    config.i18n.available_locales = [ :en, :'pt-BR' ]
    config.i18n.default_locale = :'pt-BR'
    config.autoload_lib(ignore: %w[assets tasks])
  end
end
