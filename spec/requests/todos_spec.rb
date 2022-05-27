require 'rails_helper'

RSpec.describe 'Todos API', type: :request do 
  let!(:todos) {create_list(:todo, 10)}
  let!(:todo_id) { todos.first.id }

  # tests for get /todos
  describe 'GET /todos' do
    #Make HTTP request bfore each test
    before {get '/todos'}

    it 'returns todos' do 
      expect(json).not_to_be_empty
      expect(json.size).to eq(10)
    end

    it 'retruns code 200' do
      expect(response).to have_http_status(200)
    end
  end
end

    



