# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::GroupEventsController, type: :request do
  version = 'v1'
  base_api_url = "/api/#{version}/"
  headers = { 'ACCEPT' => 'application/json' }

  let!(:group_events) { create_list(:group_event, 5) }
  let(:group_event_id) { group_events.first.id }

  it 'GET /group_events' do
    url = "#{base_api_url}group_events"
    get url, headers: headers

    # `json` is a custom helper to parse JSON responses
    expect(json).not_to be_empty
    expect(json.length).to eq(5)
    expect(response).to have_http_status(:ok)
  end

  it 'GET /group_events/:id' do
    url = "#{base_api_url}group_events/#{group_event_id}"
    get url, headers: headers

    # `json` is a custom helper to parse JSON responses
    expect(json).not_to be_empty
    expect(json['id']).to eq(group_event_id)
    expect(response).to have_http_status(:ok)
  end

  it 'POST /group_events' do
    url = "#{base_api_url}group_events"
    post url, params: { group_event: { name: 'Groupevent' } }, headers: headers

    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response).to have_http_status(:created)
  end

  it 'PUT /group_events/:id' do
    url = "#{base_api_url}group_events/#{group_event_id}"
    put url, params: { group_event: { dscription: 'Groupevent' } }, headers: headers

    expect(response.content_type).to eq('application/json; charset=utf-8')
    expect(response).to have_http_status(:ok)
  end

  it 'delete group_events/:id' do
    url = "#{base_api_url}group_events/#{group_event_id}"
    delete url, headers: headers

    expect(response).to have_http_status(:no_content)
    # Check if group event is not actually deleted from database
    group_event = GroupEvent.find_by(id: group_event_id)
    deleted_event = GroupEvent.with_deleted.find_by(id: group_event_id)
    expect(group_event).to be(nil)
    expect(deleted_event.id).to be(group_event_id)
  end
end
