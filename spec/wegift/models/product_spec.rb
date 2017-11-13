require 'spec_helper'

RSpec.describe Wegift::Product do

  describe 'GET' do

    describe 'all' do

      xit 'should return error if unauthed' do
        client = set_wegift_client_unauthed

        VCR.use_cassette('get_product_catalogue_invalid_403') do
          products = client.products

          # TODO: returns html?

          #expect(products.status).to eq(Wegift::Response::STATUS[:error])
        end
      end

      it 'should return a set of products' do
        client = set_wegift_client

        VCR.use_cassette('get_product_catalogue_valid') do
          products = client.products

          expect(products.is_a?(Array)).to eq(true)
          expect(products.first.class).to eq(Wegift::Product)
        end

      end

      it 'should return a single product' do
        client = set_wegift_client

        VCR.use_cassette('get_product_catalogue_valid') do
          products = client.products
          p = products.first

          VCR.use_cassette('get_product_item_valid') do
            product = client.product(p.code)

            expect(product.class).to eq(Wegift::Product)
            expect(product.code).to eq(p.code)
          end
        end

      end

      it 'should have instructions' do
        client = set_wegift_client
        VCR.use_cassette('get_product_item_valid_with_instructions') do
          # picked manually since it could be nil for others
          code = 'AGOS-GB'
          product = client.product(code)

          expect(product.class).to eq(Wegift::Product)
          expect(product.code).to eq(code)
          expect(product.redeem_instructions_html).not_to eq(nil)
          # ...

        end
      end

    end

  end

end