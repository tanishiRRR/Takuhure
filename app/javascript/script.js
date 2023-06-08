/* global $*/
// Cloud9の仕様によりIDEがエラーを出力するので、上のを記述することでエラーを解消

// lrarning_recordで新規作成、編集ボタンを活性化する条件
$(document).ready(function () {
  // constによって値書き換えを禁止した変数を宣言
  const $submitbtn = $('#js-submit');
  $('#form input').on('change', function () {
  if (
    $('#start_time_option').val() < $('#end_time_option').val()
    ){
      $submitbtn.prop('disabled', false);
    } else {
      $submitbtn.prop('disabled', true);
    }
  });
});