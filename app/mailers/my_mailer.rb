# frozen_string_literal: true

class MyMailer < Devise::Mailer
  helper :application

  include Devise::Controllers::UrlHelpers

  default template_path: 'devise/mailer'

  def confirmation_instructions(record, token, opts = {})
    headers['Custom-header'] = 'Bar'

    super
  end
end
