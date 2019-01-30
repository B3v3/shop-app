require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product)   { build(:product) }
  let(:product1)  { build(:product1) }

  describe 'validations' do
      it 'should accept when everything ok' do
        expect(product).to be_valid
        expect(product1).to be_valid
      end

      describe 'name' do
        it 'should be present' do
          product.name = ''
          expect(product).to be_invalid
        end

        it 'should be unique case insensitive' do
          product.save
          product1.name = product.name
          expect(product1).to be_invalid

          product1.name = product.name.swapcase
          expect(product1).to be_invalid
        end

        it 'should be shorter than 65 characters' do
          product.name = 'a' * 65
          expect(product).to be_invalid

          product.name = 'a' * 64
          expect(product).to be_valid
        end

        it 'should be longer than 2 characters' do
          product.name = 'a' * 2
          expect(product).to be_invalid

          product.name = 'a' * 3
          expect(product).to be_valid
        end
      end

      describe 'price' do
        it 'should be a number' do
          product.price = 'pision groszy'
          expect(product).to be_invalid
        end

        it 'should be present' do
          product.price = nil
          expect(product).to be_invalid
        end

        it 'should be greater or equal than 0' do
          product.price = 0
          expect(product).to be_valid

          product.price = 1
          expect(product).to be_valid

          product.price = -1
          expect(product).to be_invalid
        end
      end

      describe 'description' do
        it 'should be present' do
          product.description = ''
          expect(product).to be_invalid
        end

        it 'should be shorter than 1001 characters' do
          product.description = 'a' * 1001
          expect(product).to be_invalid

          product.description = 'a' * 1000
          expect(product).to be_valid
        end

        it 'should be longer than 1 characters' do
          product.description = 'a'
          expect(product).to be_invalid

          product.description = 'a' * 2
          expect(product).to be_valid
        end
      end
  end

end
