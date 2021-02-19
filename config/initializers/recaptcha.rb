Recaptcha.configure do |config|
  config.site_key  =  Rails.application.secrets.recaptcha_site_key
  config.secret_key  = Rails.application.secrets.recaptcha_secret_key
  #config.proxy = 'https://www.google.com/recaptcha/api/siteverify'
end
