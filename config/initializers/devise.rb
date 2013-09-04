# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  config.mailer_sender = "no-reply@hochuli.ru"
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.password_length = 8..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.allow_unconfirmed_access_for = 365.days

  config.http_authenticatable_on_xhr = false
  config.navigational_formats = ["*/*", :html, :json]
  config.omniauth :vkontakte, OAUTH['vkontakte']['app_id'], OAUTH['vkontakte']['app_secret']
  config.omniauth :odnoklassniki, OAUTH['odnoklassniki']['app_id'], OAUTH['odnoklassniki']['app_secret']
  config.omniauth :mailru, OAUTH['mailru']['app_id'], OAUTH['mailru']['app_secret']
  config.scoped_views = true
end
