require "test_helper"

class Subdomain::ResultMailerTest < ActionMailer::TestCase
  test "send_mail_student" do
    mail = Subdomain::ResultMailer.send_mail_student
    assert_equal "Send mail student", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
