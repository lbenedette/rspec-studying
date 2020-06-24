require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is valid with description, price, category' do
    product = build(:product)
    expect(product).to be_valid
  end

  it 'is invalid without description' do
    product = build(:product, description: nil)
    expect(product).to be_invalid
    expect(product.errors).to include(:description)
  end

  it 'is invalid without price' do
    product = build(:product, price: nil)
    expect(product).to be_invalid
    expect(product.errors).to include(:price)
  end

  it 'is invalid without category' do
    product = build(:product, category: nil)
    expect(product).to be_invalid
    expect(product.errors).to include(:category)
  end

  context '#formatted_price' do
    it 'with 0 places' do
      product = create(:product, price: 1)
      expect(product.formatted_price).to eq("$1.00")
    end

    it 'with 1 place' do
      product = create(:product, price: 1.5)
      expect(product.formatted_price).to eq("$1.50")
    end

    it 'with 3 places' do
      product = create(:product, price: 1.567)
      expect(product.formatted_price).to eq("$1.57")
    end
  end
end
