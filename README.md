# アプリケーション名

consumables-checker

# アプリケーション概要

工場設備の消耗品管理を効率化し、設備起因のトラブルを減らすことを目的とした管理アプリケーション

# アプリケーションを制作した背景

前職で働いていた際に、装置起因のトラブルが発生していました。原因を調査すると、装置内の消耗品の劣化や破損が大きな影響を与えていることが分かりました。工場内では多くの装置が使用されており、消耗品の管理が十分にできていない状況でした。そこで、各装置ごとの消耗品を登録し、点検期限が近づいた際にアプリ内で通知し、点検を促すアプリを開発しました。

# URL

https://consumables-checker.onrender.com

# テスト用アカウント

A株式会社
- 会社名：A株式会社
- メール：test1@test1.jp
- パスワード：testtest1

B株式会社
- 会社名：B株式会社
- メール：test2@test2.jp
- パスワード：testtest2

# 利用方法

## アイテム登録
1. ログイン画面下の「新規登録はこちら」からユーザー新規登録画面へ遷移する
2. ［アイテム登録」ボタンを押す
3. 項目を入力し、「登録」ボタンを押す
4. トップページに遷移し、登録したアイテムが表示される
[![Image from Gyazo](https://i.gyazo.com/9f839f11ff53a6bf2535e975aac5a27a.gif)](https://gyazo.com/9f839f11ff53a6bf2535e975aac5a27a)

## アイテム更新
1. 「詳細」ボタンを押す。
2. 詳細ページ下部の項目を入力し、「登録」ボタンを押す
[![Image from Gyazo](https://i.gyazo.com/e7c5ad43f1f0627bce487f360b9e26d8.gif)](https://gyazo.com/e7c5ad43f1f0627bce487f360b9e26d8)


# 実装予定の機能

メール自動送信機能で、点検日の近づいたアイテムを通知する。

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/996e674c395969cdde3f317dc85fed51.png)](https://gyazo.com/996e674c395969cdde3f317dc85fed51)

# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/5370b5a7f2529f2ae18df149fd5250f2.png)](https://gyazo.com/5370b5a7f2529f2ae18df149fd5250f2)

# 要件定義書
[![Image from Gyazo](https://i.gyazo.com/e290cc7acd5a63b92cb21e81ac85cf48.png)](https://gyazo.com/e290cc7acd5a63b92cb21e81ac85cf48)

# 開発環境

- フロントエンド
  - HTML
  - JavaScript
  - SCSS
- バックエンド
  - Ruby(v3.2.0)
  - Ruby on Rails

# ローカルでの動作確認

- 以下のコマンドを順に実行
  - % git clone https://github.com/ks022564/consumables-checker.git
  - % cd consumables-checker
  - % bundle install
  - % rails db:create
  - % rails db:migrate

# 工夫した点

1つ目は会社ごとにデータ管理できるようにしたことです。データの分離と管理、認証とアクセス制御に苦労しました。データの分離と管理はデータベース設計の見直しとスコープを使用しました。認証とアクセス制御についてはdeviseを利用しユーザー認証を実装し、会社ごとのデータ管理をできるようにしました。

2つ目はユーザーインターフェースの設計です。ユーザーが直感的に操作できるトップページにアクセスすればすぐに点検が必要なアイテムの確認ができるインタフェースを目指しました。bootstrapを使用することでユーザーフレンドリーなインタフェースを作ることができました。

3つ目はソート機能です。実務において多くのアイテムが登録されると該当のアイテムを探す手間が発生してしまうため実装しました。
