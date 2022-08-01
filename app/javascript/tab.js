// マイページのタグ切り替え
$(document).on('turbolinks:load', function () {
  let tabs = $(".tab");
  // クラス名"tab"がclickされたら、
  $('.tab').on('click', function() {
    // 今ある".tab-active"を削除
    $('.tab-active').removeClass('tab-active');
    // クリックされたら、クラス名"tab"に".tab-active"を追加
    $(this).addClass('tab-active');
    // 今表示されているcontents部分(投稿内容)も削除
    // indexという変数にtabのindex番号を代入
    const index = tabs.index(this);
    $('.tabbox').removeClass('box-show').eq(index).addClass('box-show');
  });
});