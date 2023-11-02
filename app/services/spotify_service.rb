# frozen_string_literal: true

# Spotify Client
class SpotifyService
  require 'base64'

  SPOTIFY_CONFIG = Rails.application.config.spotify
  AUTH_URL = SPOTIFY_CONFIG[:auth_url]
  TRACK_URL = SPOTIFY_CONFIG[:track_url]
  CLIENT_ID = SPOTIFY_CONFIG[:client_id]
  CLIENT_SECRET = SPOTIFY_CONFIG[:client_secret]

  attr_reader :token

  def initialize
    response = generate_token

    @token = get_token(response)
  end

  def generate_token
    response = auth
    valid_response?(response)
  end

  def get_track_info(track_id)
    response = get_track(track_id)

    valid_response?(response)
  end

  private

  def auth
    credentials = "#{CLIENT_ID}:#{CLIENT_SECRET}"

    encoded_credentials = Base64.strict_encode64(credentials)

    headers = {
      'Content-Type' => 'application/x-www-form-urlencoded',
      'Authorization' => "Basic #{encoded_credentials}"
    }

    query = { 'grant_type' => 'client_credentials' }

    HTTParty.post(AUTH_URL, headers:,
                            query:)
  end

  def valid_response?(response)
    raise StandardError, response['error'] if response.key?('error')

    response
  end

  def get_token(response)
    response['access_token']
  end

  def get_track(track_id)
    url = "#{TRACK_URL}/#{track_id}"
    headers = { 'Authorization' => "Bearer #{@token}" }

    HTTParty.get(url, headers:)
  end
end
