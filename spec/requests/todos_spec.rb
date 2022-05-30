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

  #tests for get/todos/:id
  describe 'GET /todos/:id' do
    #Make HTTP request bfore each test
    before{get "/todos/#{todo_id}"}
    
    context 'When the record exists' do
      it 'reurns todos/:id' do
        expect(json).not_to_be_empty
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
    let(:valid_attributes) { {title:'Learn Elm', created_by:1} }

    context 'when the request is valid' do
      before {post '/todos', params:valid_attributes}
    
      it 'creates a todo' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before {post '/todos', params: {title:'Foobar'}}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'it returns a validation failure message' do 
        expect(response.body).to eq(/Validation failed: Created by cant't be blank/)
      end
    end
  end

  #tests for DELETE /todos/:id
  describe 'test DELETE /todos/:id' do
    before {delete "/todos/#{todo_id}"}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

    



