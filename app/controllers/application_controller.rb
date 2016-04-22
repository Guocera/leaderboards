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
    client_id = ENV['CLIENT_ID']
    client_secret = ENV['CLIENT_SECRET']
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

  def program_tag_length
    program_tag.length
  end

  def get_redirect_url
    ENV['REDIRECT_URL']
  end

end
