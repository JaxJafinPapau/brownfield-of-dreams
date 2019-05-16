# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@turing-tutorials.com'
  layout 'mailer'
end
