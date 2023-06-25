/* global $*/
// Cloud9の仕様によりIDEがエラーを出力するので、上のを記述することでエラーを解消

// 二桁に調整するための設定
function double_digit(num) {
  // 桁数が1桁だったら先頭に0を加えて2桁に調整する
  // グローバル変数を定義
   var ret;
   if( num < 10 ) { ret = "0" + num; }
   else { ret = num; }
   return ret;
}

// 現在時刻を表示する
function showClock1() {
  // 現在日時を得る
  var realtime = new Date();
  // 年月日等必要情報を抜き出す
  var month = double_digit(realtime.getMonth() + 1);
  var date = double_digit(realtime.getDate());
  var day = realtime.getDay();
  var hour = double_digit(realtime.getHours());
  var minutes  = double_digit(realtime.getMinutes());
  var seconds  = double_digit(realtime.getSeconds());
  // 表示内容を設定する
  var msg1 = month + "月" + date + "日" + "(" + day + ")";
  var msg2 = hour + ":" + minutes + ":" + seconds;
  // id名「RealtimeClockArea」を指定した領域に掲載
  document.getElementById("Realdate").innerHTML = msg1;
  document.getElementById("Realtime").innerHTML = msg2;
}
// setInterval('実行する内容',実行間隔);で数値の単位は「ミリ秒」で表記される。
// 1秒ごとに処理を行いたければ「1000」と記述。
setInterval('showClock1()',1000);