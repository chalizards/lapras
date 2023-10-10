# frozen_string_literal: true

require 'rails_helper'
require 'pry'
require 'spotify_service'

RSpec.describe 'SpotifyService' do
  describe 'initialize' do
    context 'when the token is valid' do
      it 'creates a new Spotify object' do
        response = { 'access_token' => 'eevee',
                     'token_type' => 'Bearer',
                     'expires_in' => 3600 }

        allow(HTTParty).to receive(:post).and_return(response)

        request = SpotifyService.new
        expect(request.token).to eq('eevee')
      end

      it 'returns an error if the token is invalid' do
        response = { 'error' => 'invalid_client' }

        allow(HTTParty).to receive(:post).and_return(response)

        expect { SpotifyService.new }.to raise_error(StandardError)
      end
    end
  end

  describe 'get_track' do
    context 'when auth token and track id are valid' do
      it 'returns track info' do
        auth_response = { 'access_token' => 'eevee',
                          'token_type' => 'Bearer',
                          'expires_in' => 3600 }

        allow(HTTParty).to receive(:post).and_return(auth_response)

        track_id = '5pKCDm2fw4k6D6C5Rk646C'

        track_response = {
          'id' => track_id,
          'name' => "Tears Don't Fall"
        }

        allow(HTTParty).to receive(:get).and_return(track_response)

        request = SpotifyService.new

        track = request.get_track_info(request.token, track_id)

        expect(track['name']).to eq("Tears Don't Fall")
        expect(track['id']).to eq('5pKCDm2fw4k6D6C5Rk646C')
      end
    end

    context 'when auth token is valid and track id is invalid' do
      it 'returns an error' do
        auth_response = { 'access_token' => 'eevee',
                          'token_type' => 'Bearer',
                          'expires_in' => 3600 }

        allow(HTTParty).to receive(:post).and_return(auth_response)

        track_response = { 'error' => { 'status' => 400, 'message' => 'invalid id' } }

        allow(HTTParty).to receive(:get).and_return(track_response)

        request = SpotifyService.new

        expect { request.get_track_info(request.token, 'bulbasauro') }.to raise_error(StandardError)
      end
    end
  end
end
