class ApplicationController < ActionController::Base
  # Permite apenas navegadores modernos (opcional, padrão do Rails 8)
  allow_browser versions: :modern

  # Inclui as funcionalidades de backend da gem Pagy
  include Pagy::Backend
end