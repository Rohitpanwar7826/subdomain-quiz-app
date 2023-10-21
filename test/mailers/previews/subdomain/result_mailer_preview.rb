# Preview all emails at http://localhost:3000/rails/mailers/subdomain/result_mailer
class Subdomain::ResultMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/subdomain/result_mailer/send_mail_student
  def send_mail_student
    Subdomain::ResultMailer.send_mail_student
  end

end
