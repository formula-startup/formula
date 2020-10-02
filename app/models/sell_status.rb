class SellStatus < ActiveHash::Base
  include ActiveHash::Associations

  self.data = [
    {id:1, status:"出品中"},
    {id:2, status:"交渉中"},
    {id:3, status:"公開停止中"},
    {id:4, status:"SOLD"}
  ]

end