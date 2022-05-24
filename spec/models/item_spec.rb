require 'rails_helper'
require 'spec_helper'
require 'action_controller'

RSpec.describe Item, type: :model do
  #asociations tests
  it {should belong_to(:todo)}

  #validation tests
  it {should validate_presence_of(:name)}
end
