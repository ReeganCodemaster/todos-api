require 'rails_helper'
require 'spec_helper'
require 'action_controller'

RSpec.describe Todo, type: :model do
  #relationship tets
  #Test if Todo has 1:m relationship
  it {should have_many(:items).dependendent(:destroy)}
  #validation test
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:created_by)}
end
