require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @category = Category.create(name: "furniture")
    @product = @category.products.create(name: "Chair", description: "Four legged wooden chair", price_cents: 100, quantity: 500)
  end

  describe 'creation' do
    it 'should have one product created after being saved' do
      expect(@product).to be_valid
    end
  end

  describe 'Validations' do
    it "should not let a product be created without a name" do
      @product.name = nil
      expect(@product).to_not be_valid
    end

    it "should not let a product be created without a price_cents" do
      @product.price_cents = nil
      expect(@product).to_not be_valid
    end

    it "should not let a product be created without a quantity" do
      @product.quantity = nil
      expect(@product).to_not be_valid
    end

    it "should not let a product be created without a category_id" do
      @product.category = nil
      expect(@product).to_not be_valid
    end

  end
end
