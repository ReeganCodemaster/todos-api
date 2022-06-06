require 'rails_helper'

RSpec.describe 'Todos API', type: :request do 
  let(:user) { create(:user) }
  let!(:todos) {create_list(:todo, 10, created_by: user.id)}
  let!(:todo_id) { todos.first.id }
  let(:headers) { valid_headers }

  # tests for get /todos
  describe 'GET /todos' do
    #Make HTTP request bfore each test
    before {get '/todos', params: {}, headers:headers}

    it 'returns todos' do 
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'retruns code 200' do
      expect(response).to have_http_status(200)
    end
  end

  #tests for get/todos/:id
  describe 'GET /todos/:id' do
    #Make HTTP request bfore each test
    before{get "/todos/#{todo_id}", params:{}, headers: headers}
    
    context 'When the record exists' do
      it 'reurns todos/:id' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end
    end 

    it 'retruns status code 200' do 
      expect(response).to have_http_status(200)  
    end

    context 'When the record does not exist' do 
      let(:todo_id) {100}

      it 'returns status code 404' do 
        expect(response).to have_http_status(404)
      end

      it 'returns a not found error message' do 
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  #tets for POST /todos
  describe 'POST /todos' do 
    #creating valid payload 
    let(:valid_attributes) do
       {title:'Learn Elm', created_by:user.id.to_s}.to_json
    end

    context 'when the request is valid' do
      before {post '/todos', params:valid_attributes, headers: headers }
    
      it 'creates a todo' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { {title: nil}.to_json }
      before {post '/todos', params:invalid_attributes, headers: headers}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'it returns a validation failure message' do 
        expect(json['message']).to match(/Validation failed: Title by can't be blank/)
      end
    end
  end

  describe 'PUT /todos/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/todos/#{todo_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  #tests for DELETE /todos/:id
  describe 'test DELETE /todos/:id' do
    before {delete "/todos/#{todo_id}", params:{}, headers:headers}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

    



