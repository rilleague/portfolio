class Skin < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択して下さい' },
    { id: 2, name: '乾燥肌' },
    { id: 3, name: 'アトピー肌' },
    { id: 4, name: 'オイリー肌' },
    { id: 5, name: '混合肌' },
    { id: 6, name: '普通肌' }
  ]
end