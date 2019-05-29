FactoryGirl.define do
  factory :product do
    name 'Amazing Product'
    sku_id SecureRandom.hex(6)
    description 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
                tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
                consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
                cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
                proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    price '200'
    images [{'img_path' => 'https://cms-assets.tutsplus.com/uploads/users/1168/posts/25681/preview_image/rubyrails11.png'}]
    expire_date '2040-10-05'
    admin_approved true

    after(:save) { |product| product.categories << FactoryGirl.create(:category) } 

    factory :product_categories do
      product {|a| a.association(:product)}
      category {|a| a.association(:category)}
    end
  end
end
