class DeliverDay < ActiveHash::Base
  include ActiveHash::Associations

  # 商品発送までの日数
  self.data = [
    {id: 1, days: "1-2日で発送"},
    {id: 2, days: "2-3日で発送"},
    {id: 3, days: "3-4日で発送"}
  ]

end