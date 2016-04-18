class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  require 'oauth2'

  private

  def token
    @token ||= get_access_token
  end

  def get_access_token
    client = get_client
    OAuth2::AccessToken.new(client, session[:token])
  end

  def get_client
    site_path = 'https://branchoutdev.nationbuilder.com'
    client_id = OAUTH_CONFIG['client_id']
    client_secret = OAUTH_CONFIG['client_secret']
    client = OAuth2::Client.new(
      client_id, 
      client_secret,
      site: site_path
    )
  end

  def site_slug
    'branchoutdev'
  end

  def program_tag
    "branchy-program"
  end

  def get_redirect_url
    redirect_uri = 'http://localhost:3000/oauth/new'
  end

end
