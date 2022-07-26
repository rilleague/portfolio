class Age < ActiveHash::Base
  self.data = [
    {id: 1, name: '選択して下さい'},
    {id: 2, name: '10代'},
    {id: 3, name: '20代'},
    {id: 4, name: '30代'},
    {id: 5, name: '40代'}
  ]
    include ActiveHash::Associations
    has_many :users
end