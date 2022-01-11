require 'rails_helper'

RSpec.describe Product, type: :model do

  describe  'Validations' do

    # before(:all) do
    # end

    it "should save all fields successfully" do
      @category = Category.new(:name => 'Test category name')
      @product = Product.new(
        :name => 'Test product name',
        :price_cents => 9999,
        :quantity => 10,
        :category => @category
      )
      expect(@product.valid?).to be true
      # expect(@product).to be_valid
    end

    it 'should be nil for name' do
      @category = Category.new(:name => 'Test category name')
      @product = Product.new(
        :name => nil, # validation field
        :price_cents => 9999,
        :quantity => 10,
        :category => @category
      )
      expect(@product.valid?).to be false
      # p @product.errors.full_messages
      expect(@product.errors.full_messages).to include("Name can't be blank")
      # p @product.errors[:name]
      # expect(@product.errors[:name]).not_to include("can't be blank")
    end

    it 'should be nil for price' do
      @category = Category.new(:name => 'Test category name')
      @product = Product.new(
        :name => 'Test product name',
        :price_cents => nil, # validation field
        :quantity => 10,
        :category => @category
      )
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should be nil for quantity' do
      @category = Category.new(:name => 'Test category name')
      @product = Product.new(
        :name => 'Test product name',
        :price_cents => 9999,
        :quantity => nil, # validation field
        :category => @category
      )
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should exist for category' do
      @product = Product.new(
        :name => 'Test product name',
        :price_cents => 9999,
        :quantity => 10,
        :category => nil # validation field
      )
      expect(@product.valid?).to be false
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
