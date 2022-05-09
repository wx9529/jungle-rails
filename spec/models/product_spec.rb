require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "is valid" do 
      @cat = Category.create(name:"Test")
      @product = @cat.products.create(name:"Test",price_cents:200,quantity:20, category:@cat)
      expect(@product.valid?).to be true
    end
    it 'name presence' do
      @cat = Category.create(name:"Test")
      @product = @cat.products.create(name:nil)
      @product.valid?
      expect(@product.errors[:name]).to include("can't be blank")

      @product_new = @cat.products.create(name:"product1")
      @product_new.valid?
      expect(@product_new.errors[:name]).not_to include("can't be blank")
    end

    it 'price presence' do
      @cat = Category.create(name:"Test")
      @product = @cat.products.create(price_cents:nil)
      @product.valid?
      expect(@product.errors[:price_cents]).to include("is not a number")

      @product_new = @cat.products.create(price_cents:300)
      @product_new.valid?
      expect(@product_new.errors[:price_cents]).not_to include("is not a number")
    end

    it 'quantity presence' do
      @cat = Category.create(name:"Test")
      @product = @cat.products.create(quantity:nil)
      @product.valid?
      expect(@product.errors[:quantity]).to include("can't be blank")

      @product_new = @cat.products.create(quantity:30)
      @product_new.valid?
      expect(@product_new.errors[:quantity]).not_to include("can't be blank")
    end
  
    it 'has category_id' do
      @product_new = Product.create()
      @product_new.valid?
      expect(@product_new.errors[:category]).to include("can't be blank")

      @cat = Category.create(name:"Test")
      @product = @cat.products.create()
      @product.valid?
      expect(@product.errors[:category]).not_to include("can't be blank")
    end
  

  end
end