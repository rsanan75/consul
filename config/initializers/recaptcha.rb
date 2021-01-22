Recaptcha.configure do |config|
  config.site_key  = ENV['RECAPTCHA_PUBLIC_KEY']
  config.secret_key  = ENV['RECAPTCHA_PRIVATE_KEY']
  config.proxy = 'https://www.google.com/recaptcha/api/verify'
end
