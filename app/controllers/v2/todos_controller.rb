class V2::TodosController < ApplicationController
  def index
    json_response({ message:'Helle there'})
  end
end
