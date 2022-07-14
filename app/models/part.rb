class Part < ActiveHash::Base
  self.data = [
    { id: 1, name: '選択して下さい' },
    { id: 2, name: '全身' },
    { id: 3, name: '頭' },
    { id: 4, name: '髪' },
    { id: 5, name: '顔' },
    { id: 6, name: '腕' },
    { id: 7, name: '手' },
    { id: 8, name: '爪' },
    { id: 9, name: '胸' },
    { id: 10, name: '腹' },
    { id: 11, name: '尻' },
    { id: 12, name: '足' },
    { id: 13, name: 'その他' }
  ]
end