require "rails_helper"

RSpec.describe "/api/v1/products", :type => :request do
  let(:valid_params) do 
        { :product => {:expire_date => "2016-09-05",
          :name => "Pantene Shampoo",
          :sku_id =>  SecureRandom.hex(6),
          :categories => [
              "beauty", "health", "haircare"
          ],
          :tags => [
              "pantene", "shampoo"
          ],
          :images => [{
              :img_path => "https://images-static.nykaa.com/media/catalog/product/tr:h-800,w-800,cm-pad_resize/4/9/4902430647007_1a_.jpg"
          }, {
              :img_path => "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3O1IMf-Ss-fHs5LmV8X6bADl1oe4fNUEbPC5a0AaeiAA2qMIR"
          }],
          :price => 229,
          :description => "Now with the Best Ever Pantene, get hair that's 'Stonger Inside, Shinier Outside'. Contains Keratin Damage Blockers technology that helps prevent hair breakage caused by damage, resulting in up to 98% less hair fall when used daily. Strengthens hair from root to tip. Prevents damage that results in hair breakage."
      }
    }
  end

  it "creates a new product" do
    expect { post "/api/v1/products", valid_params }.to change(Product, :count).by(+1)
    expect(response).to have_http_status :success
    expect(response.content_type).to eq("application/json")
  end
end