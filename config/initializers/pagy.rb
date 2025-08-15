# config/initializers/pagy.rb

# Esta é a linha mais importante. Ela "ativa" todos os helpers de view
# específicos para o Bootstrap, como o pagy_bootstrap_nav.
require 'pagy/extras/bootstrap'

# BÔNUS: Podemos definir aqui o número padrão de itens por página para todo o site.
Pagy::DEFAULT[:items] = 10