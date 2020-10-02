FactoryBot.define do
  factory :user do
    password = Faker::Internet.password(8)
    nickname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { password }
    password_confirmation { password }
  end
  factory :profile do
    birthyear {1111}
    birthmonth {11}
    birthday {11}
    family_name {Faker::Name.first_name}
    personal_name {Faker::Name.last_name}
    family_name_kana {Faker::Name.first_name}
    personal_name_kana {Faker::Name.last_name}
    post_family_name {Faker::Name.first_name}
    post_personal_name {Faker::Name.last_name}
    post_family_name_kana {Faker::Name.first_name}
    post_personal_name_kana {Faker::Name.last_name}
    prefecture {Faker::Address.street_name}
    city {Faker::Address.city}
    address {Faker::Address.street_address}
    building {Faker::Address.building_number}
    postal_code {"999-1111"} 
  end
end
