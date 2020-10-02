FactoryBot.define do


  factory :category_index do
    id                {1}
    name              {"テックエキスパート問題集"}
  end

  factory :product do
    title             {Faker::Superhero.name}
    text              {Faker::ChuckNorris.fact}
    category_index_id {1}
    fresh_status      {"新品、未使用"}
    deliver_way       {"ゆうパック"}
    deliver_person    {"送料込み(出品者負担)"}
    from_area         {"三重県"}
    deliver_leadtime  {"3-4日で発送"}
    price             {"400"}
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  end

end