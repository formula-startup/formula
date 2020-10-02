# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

CSV.foreach('db/seeds/csv/all_category.csv', encoding: 'Shift_JIS:UTF-8', headers:true ) do |row|
  # カテゴリ、サイズ名を取得
  index         = row['index']
  bigcategory   = row['bigcategory']
  smallcategory = row['smallcategory']
  size          = row['size']
  # 要素の作成、各テーブルへ保存
  category_content      = CategoryIndex.find_or_create_by(name: index)
  bigcategory_content   = Bigcategory.find_or_create_by(
    name: bigcategory,
    category_index_id: category_content.id
  )
  smallcategory_content = Smallcategory.find_or_create_by(
    name: smallcategory,
    bigcategory_id: bigcategory_content.id
  )
  unless size.nil?
    size_content        = Size.find_or_create_by(name: size)
    SmallcategoriesHasSize.find_or_create_by(
      smallcategory_id: smallcategory_content.id,
      size_id: size_content.id
    )
  end
end

# テストユーザー
testuser      = User.create(
  email:                 "techexpert@techmaster.com",
  nickname:              "tech-expert-58",
  password:              "techexpert58",
  password_confirmation: "techexpert58"
)
testprofile   = Profile.create(
  user_id:                 1,
  birthyear:               2019,
  birthmonth:              7,
  birthday:                27,
  family_name:             "てっく",
  personal_name:           "すぱお",
  family_name_kana:        "テック",
  personal_name_kana:      "スパオ",
  postal_code:             "739-0133",
  prefecture:              "福岡県",
  city:                    "東広島市城南区飯田",
  address:                  "１０－８２９－２８１０, ラポールエキスパート５８号室",
  building:                Faker::Address.unique.building_number,
  post_family_name:        "てっく",
  post_personal_name:      "すぱお",
  post_family_name_kana:   "テック",
  post_personal_name_kana: "スパオ"
)
10.times{
  user        = User.create(
    email:                 Faker::Internet.email,
    nickname:              Faker::JapaneseMedia::DragonBall.unique.character,
    password:              "password58",
    password_confirmation: "password58"
  )
  first_name  = Faker::Name.unique.first_name
  last_name   = Faker::Name.unique.last_name
  testprofile = Profile.create(
    user_id:                 user.id,
    birthyear:               rand(1900..2019),
    birthmonth:              rand(1..12),
    birthday:                rand(1..28),
    family_name:             last_name,
    personal_name:           first_name,
    family_name_kana:        last_name,
    personal_name_kana:      first_name,
    postal_code:             "#{rand(100..999)}-#{rand(1000..9999)}",
    prefecture:              Prefecture.find(rand(1..47)).name,
    city:                    Faker::Address.unique.city,
    address:                 Faker::Address.unique.street_address,
    building:                Faker::Address.unique.building_number,
    post_family_name:        last_name,
    post_personal_name:      first_name,
    post_family_name_kana:   last_name,
    post_personal_name_kana: first_name
  )  
}


# テスト商品
testproduct   = Product.create(
  title:             "test product",
  text:              "test text",
  category_index_id: 1,
  bigcategory_id:    1,
  smallcategory_id:  1,
  size_id:           1,
  fresh_status:      "新品、未使用",
  deliver_person:    "送料込み(出品者負担)",
  deliver_way:       "ゆうパック",
  deliver_leadtime:  "3-4日で発送",
  from_area:         "三重県",
  price:             "3000",
  user_id:           1
)
testimage     = ProductImage.create(
  image:File.open("./app/assets/images/aquos.jpeg"),
  product_id: 1
)

# 交渉中商品
testproduct2  = Product.create(
  title:             "TRADING product",
  text:              "TRADING text",
  category_index_id: 2,
  bigcategory_id:    2,
  smallcategory_id:  2,
  size_id:           2,
  fresh_status:      "新品、未使用",
  deliver_person:    "送料込み(出品者負担)",
  deliver_way:       "ゆうパック",
  deliver_leadtime:  "3-4日で発送",
  from_area:         "福岡県",
  price:             "3000",
  user_id:           1,
  sell_status:       SellStatus.find(2).status
)
testimage2    = ProductImage.create(
  image:File.open("./app/assets/images/aquos.jpeg"),
  product_id: 2
)

# 公開停止中タグの商品
testproduct3  = Product.create(
  title:             "STOP SELLING product",
  text:              "STOP SELLING text",
  category_index_id: 3,
  bigcategory_id:    3,
  smallcategory_id:  3,
  size_id:           3,
  fresh_status:      "新品、未使用",
  deliver_person:    "送料込み(出品者負担)",
  deliver_way:       "ゆうパック",
  deliver_leadtime:  "3-4日で発送",
  from_area:         "福岡県",
  price:             "3000",
  user_id:           1,
  sell_status:       SellStatus.find(3).status
)
testimage3    = ProductImage.create(
  image:File.open("./app/assets/images/aquos.jpeg"),
  product_id: 3
)

# SOLD OUTタグの商品
testproduct4  = Product.create(
  title:             "SOLD OUT product",
  text:              "SOLD OUT text",
  category_index_id: 4,
  bigcategory_id:    4,
  smallcategory_id:  4,
  size_id:           4,
  fresh_status:      "新品、未使用",
  deliver_person:    "送料込み(出品者負担)",
  deliver_way:       "ゆうパック",
  deliver_leadtime:  "3-4日で発送",
  from_area:         "佐賀県",
  price:             "3000",
  user_id:           1,
  sell_status:       SellStatus.find(4).status
)
testimage3        = ProductImage.create(
  image:File.open("./app/assets/images/aquos.jpeg"),
  product_id: 4
)

# ダミー商品
40.times{
  category_index = rand(1..13)
  bigcategory    = Bigcategory.where(category_index_id: category_index).sample
  smallcategory  = Smallcategory.where(bigcategory_id: bigcategory).sample
  sizes          = Smallcategory.find_by(id: smallcategory.id).smallcategories_has_sizes.sample
  if sizes.present?
    size         = sizes.size_id
  else
    size         = nil
  end
  product        = Product.create(
    title:             Faker::Device.unique.model_name,
    text:              Faker::Quote.unique.most_interesting_man_in_the_world,
    category_index_id: category_index,
    bigcategory_id:    bigcategory.id,
    smallcategory_id:  smallcategory.id,
    size_id:           size,
    fresh_status:      ProductFreshness.find(rand(1..6)).status,
    deliver_person:    DeliverFee.find(rand(1..2)).fee,
    deliver_way:       DeliverWay.find(rand(1..9)).way,
    deliver_leadtime:  DeliverDay.find(rand(1..3)).days,
    from_area:         Prefecture.find(rand(1..47)).name,
    price:             rand(100000),
    user_id:           rand(1..User.count),
  )
  testimage      = ProductImage.create(
    image:File.open("./app/assets/images/aquos.jpeg"),
    product_id: product.id
  )
}

40.times{
  testimage      = ProductImage.create(
    image:File.open("./app/assets/images/aquos.jpeg"),
    product_id: rand(1..Product.count))
}

