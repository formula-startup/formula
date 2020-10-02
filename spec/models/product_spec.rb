require 'rails_helper'

describe Product do
  describe '#create' do
    it 'is invalid without a title' do
      product = build(:product, title:"")
      product.valid?
      expect(product.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a text' do
      product = build(:product, text:"")
      product.valid?
      expect(product.errors[:text]).to include("can't be blank")
    end

    it 'is invalid with --- at fresh_status' do
      product = build(:product, fresh_status:"---")
      product.valid?
      expect(product.errors[:fresh_status]).to include("is reserved")
    end

    it 'is invalid with --- at delivery_way' do
      product = build(:product, deliver_way:"---")
      product.valid?
      expect(product.errors[:deliver_way]).to include("is reserved")
    end

    it 'is invalid with --- at delivery_person' do
      product = build(:product, deliver_person:"---")
      product.valid?
      expect(product.errors[:deliver_person]).to include("is reserved")
    end

    it 'is invalid with 都道府県 at from_area' do
      product = build(:product, from_area:"都道府県")
      product.valid?
      expect(product.errors[:from_area]).to include("is reserved")
    end

    it 'is invalid with --- at deliver_leadtime' do
      product = build(:product, deliver_leadtime:"---")
      product.valid?
      expect(product.errors[:deliver_leadtime]).to include('is reserved') 
    end
  end
end