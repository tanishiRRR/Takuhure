class DevisePublicMailer < Devise::Mailer
  def headers_for(action, opts)
    super.merge!(template_path: 'public/mailers')
  end
end