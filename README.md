# pwscup2019eval
## 使い方
PWSCUP2019の支援する機能を盛り込んでいきます
* データを投稿すると、フォーマットが正しいかどうかをチェックしてくれる
* データを投稿すると、有用性を評価してくれる

![動作イメージ](https://github.com/gghatano/pwscup2019eval/blob/images/PWSCUP2019_evalsystem.jpg?raw=true)


# バグ報告
* ISSUEを立てるか, [Twitter](https://twitter.com/gg_hatano)で連絡してください

# 実行・開発方法
Rstudioの利用を推奨します R と Shinyの知識が必要です
* 本レポジトリをローカルにクローン
* RstudioのFile > Open project でRpojファイルを開く
* 適当にbranchを切って、適当に直してプルリクを送る

# ファイル構成
* ui.R : 画面の見た目だけ定義するところ 
* server.R : server/server_(tab名).Rを読み込むだけ
* server/server_(tab名).R : ダッシュボードのタブごとに定義された処理を実装している
  * server/format_check_anon.R : 匿名加工後データのフォーマットチェッカ 
  * server/format_check_reid.R : ID再識別データのフォーマットチェッカ
  * server/format_check_retrace.R : トレース推定のフォーマットチェッカ

## 連絡先
Twitter: @gg_hatano
