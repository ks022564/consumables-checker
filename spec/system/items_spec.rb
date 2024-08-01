require 'rails_helper'

RSpec.describe "Items", type: :system do
  before do
    before do
      @item = FactoryBot.build(:item)
    end   
  end
end