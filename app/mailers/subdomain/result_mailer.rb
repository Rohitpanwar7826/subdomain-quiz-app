class Subdomain::ResultMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.subdomain.result_mailer.send_mail_student.subject
  #
  def send_mail_student
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
