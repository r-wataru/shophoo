# Shophoo

これはショッピングサイトのデモです。

出来る事

* ユーザー(User)登録出来ます。
* カート(ShoppingCart)に商品を追加できます。
* お気に入り(BookmarkFolder)に商品を追加できます。
* 商品を購入できます。
* 団体を作成できます。
* 団体から商品を作成できます。

以下環境

* Ruby 2.1.1

* Rails 4.1.1

* Mysql2

セットアップ

```sh
$ git clone git@github.com:r-wataru/shophoo.git
$ bundle install
$ bundle exec rake db:migrate
$ bundle exec rake db:seed
$ rails s
```

テスト

```
$ rake db:migrate RAILS_ENV=test
$ bundle exec rspec spec
```
