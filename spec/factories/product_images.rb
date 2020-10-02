FactoryBot.define do

  factory :product_image do
    image      {File.open("./app/assets/images/aquos.jpeg")}
    product_id {1}
  end

end