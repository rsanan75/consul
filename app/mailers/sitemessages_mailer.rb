class SitemessagesMailer < ApplicationMailer
  def contact_email(sitemessage)
    @sitemessage = sitemessage
    mail(to: 'sbolleddula@worldbankgroup.org', subject: 'Welcome to My Awesome Site')
  end
end
