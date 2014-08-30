== Shophoo

これはショッピングサイトのデモです。

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