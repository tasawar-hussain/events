require 'swagger_helper'

describe 'group Events API' do
  path '/api/v1/group_events' do
    get 'Get All Group Events' do
      tags 'Group Events'
      consumes 'application/json'

      response '200', 'Get all group events' do
        run_test!
      end
    end
  end

  path '/api/v1/group_events/{id}' do
    get 'Get a Group Event' do
      tags 'Group Events'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Group event found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 description: { type: :string }
               },
               required: %w[id]

        let(:id) { GroupEvent.create(name: 'foo', description: 'bar').id }
        run_test!
      end

      response '404', 'Group event not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/group_events' do
    post 'Create a Group Event' do
      tags 'Group Events'
      consumes 'application/json'

      parameter name: :group_event, in: :body, schema: {
        type: :object,
        properties: {
          group_event: {
            type: :object,
            properties: {
              name: { type: :string },
              description: { type: :string },
              location: { type: :string },
              start_date: { type: :string, example: '20-12-2020' },
              end_date: { type: :string, example: '27-12-2020' },
              published: { type: :boolean, example: 'true' }
            }
          }
        },
        required: %i[group_event]
      }

      response '201', 'Group event created' do
        schema type: :object,
               properties: {
                 id: { type: :integer }
               },
               required: %w[id]
        let(:group_event) { { name: 'foo', desscription: 'bar' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:group_event) { { hi: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/group_events/{id}' do
    put 'Update a Group Event' do
      tags 'Group Events'
      consumes 'application/json'

      parameter name: :id, in: :path, type: :string

      parameter name: :group_event, in: :body, schema: {
        type: :object,
        properties: {
          group_event: {
            type: :object,
            properties: {
              name: { type: :string },
              start_date: { type: :string, example: '20-12-2020' },
              end_date: { type: :string, example: '27-12-2020' }
            }
          }
        },
        required: %i[group_event]
      }

      let(:group_event) { GroupEvent.create(name: 'foo', end_date: '27-12-2020')}

      response '200', 'roup event updated' do
        let(:id) { GroupEvent.create(name: 'foo', description: 'bar').id }
        run_test!
      end

      # Parameter Object for Body
      response '404', 'Group event not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/group_events/{id}' do
    delete 'Delete a Group Event' do
      tags 'Group Events'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '204', 'Group event found' do
        let(:id) { GroupEvent.create(name: 'foo', description: 'bar').id }
        run_test!
      end

      response '404', 'Group event not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end
