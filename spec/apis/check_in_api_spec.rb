require 'spec_helper'

def app
  ApplicationApi
end

describe CheckInApi do
  include Rack::Test::Methods

  let(:url) { "#{BASE_PATH}/check_ins" }

  let(:create_check_in_with_coordinates) do
    post url, attributes_for(:check_in_with_coordinates)
    JSON.parse(last_response.body)
  end

  let(:create_check_in) do
    post url, attributes_for(:check_in)
    JSON.parse(last_response.body)
  end

  let(:valid_fields) { %w(id name message lat lng created_at updated_at) }

  describe 'with auth' do

    include_context 'authenticate'

    describe 'GET /check_ins' do

      it 'returns list of check ins' do
        check_in = create_check_in
        expect(last_response.status).to eq 201
        get url
        expect(last_response.status).to eq 200
        results = JSON.parse(last_response.body)
        expect(results.is_a? Array).to be true
        expect(results).to include check_in
      end

    end

    describe 'POST /check_ins' do

      it 'creates a minimal check in' do
        check_in = create_check_in
        expect(last_response.status).to eq 201
        valid_fields.each do |key|
          expect(check_in.key? key).to be true
        end
      end

      it 'creates a complete check in' do
        check_in = create_check_in_with_coordinates
        expect(last_response.status).to eq 201
        valid_fields.each do |key|
          expect(check_in.key? key).to be true
        end
        expect(check_in['lat']).to_not be_nil
        expect(check_in['lng']).to_not be_nil
      end

      it 'shows error when missing params' do
        post url, {}
        expect(last_response.status).to eq 400
      end

    end

    describe 'GET /check_ins/:id' do

      it 'shows a check in' do
        check_in = create_check_in
        expect(last_response.status).to eq 201
        get "#{url}/#{check_in['id']}"
        expect(last_response.status).to eq 200
        expect(check_in).to eq JSON.parse(last_response.body)
      end

      it 'shows error when check in does not exist' do
        get "#{url}/423423434"
        expect(last_response.status).to eq 404
      end

    end

    describe 'PUT /check_ins/:id' do

      it 'updates a check in' do
        check_in = create_check_in
        expect(last_response.status).to eq 201
        check_in['message'] = 'a new message'
        put "#{url}/#{check_in['id']}", check_in.slice('message')
        expect(last_response.status).to eq 200
        new_check_in = JSON.parse(last_response.body)
        expect(check_in['message']).to eq new_check_in['message']
      end

      it 'shows error when check in does not exist' do
        check_in = create_check_in
        expect(last_response.status).to eq 201
        put "#{url}/21398123", check_in.slice(:name)
        expect(last_response.status).to eq 404
      end

    end

  end

  describe 'without auth' do

    include_context 'invalid token'

    describe 'GET /check_ins' do

      it 'show not authenticated error' do
        get url
        expect(last_response.status).to eq 401
      end

    end

    describe 'POST /check_ins' do

      it 'show not authenticated error' do
        create_check_in
        expect(last_response.status).to eq 401
      end

    end

    describe 'GET /check_ins/:id' do

      it 'show not authenticated error' do
        get "#{url}/1"
        expect(last_response.status).to eq 401
      end

    end

    describe 'PUT /check_ins/:id' do

      it 'show not authenticated error' do
        put "#{url}/1", attributes_for(:check_in)
        expect(last_response.status).to eq 401
      end

    end

  end

end
