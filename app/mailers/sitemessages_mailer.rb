class SitemessagesMailer < ApplicationMailer
  def contact_email(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(to: 'pusulacyprus@gmail.com', subject: 'New message!')
  end
  def contact_email_all(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(to: 'pusulacyprus@gmail.com', subject: 'New Contact us message!')
  end
end