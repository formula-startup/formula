class DeliverWay < ActiveHash::Base
  include ActiveHash::Associations

  self.data = [
    {id:1, way:"未定"},
    {id:2, way:"クロネコヤマト"},
    {id:3, way:"ゆうパック"},
    {id:4, way:"ゆうメール"},
    {id:5, way:"らくらくメルカリ便"},
    {id:6, way:"レターパック"},
    {id:7, way:"普通郵便(定形、定形外)"},
    {id:8, way:"クリックポスト"},
    {id:9, way:"ゆうパケット"}
  ]

end