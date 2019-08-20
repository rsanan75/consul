module Consul
  class Application < Rails::Application
  	config.i18n.default_locale = :en
    available_locales = [
      "el",
      "en",
      "tr",]
    config.i18n.available_locales = available_locales
    config.i18n.fallbacks = {
      "fr"    => "es",
      "gl"    => "es",
      "it"    => "es",
      "pt-BR" => "es"
    }
    config.assets.precompile += Ckeditor.assets
    config.assets.precompile += %w( ckeditor/* )
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
  end
end
