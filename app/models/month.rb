class Month < ActiveHash::Base
  self.data = [
    {id: 1,value: 1,show: "01"},   {id: 2,value: 2,show: "02"},
    {id: 3,value: 3,show: "03"},   {id: 4,value: 4,show: "04"},
    {id: 5,value: 5,show: "05"},   {id: 6,value: 6,show: "06"},
    {id: 7,value: 7,show: "07"},   {id: 8,value: 8,show: "08"},
    {id: 9,value: 9,show: "09"},   {id: 10,value: 10,show: "10"},
    {id: 11,value: 11,show: "11"}, {id: 12,value: 12,show: "12"}
  ]
end