class WelcomeMailer < ApplicationMailer
  def welome_account_email(email)
    mail(to: email, subject: 'Welome to Emporia Wallet!')
  end

  def welome_account_email_admin(email)
    mail(to: email, subject: 'Welome to Emporia Wallet!')
  end
end
