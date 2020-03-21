# README
気合

# 初回起動時
* `docker-compose build`
* `docker-compose run --rm web bin/setup`
  * 以下が実行される
  * `bundle install`, `yarn install`, `rails db:prepare`
  * `bundle exec rails db:drop db:create db:migrate musicbar:create_initial_data musicbar:scraping_all`
* `docker-compose up -d`

* http://localhost:3000/にアクセスする
（サーバーが立つまでにめちゃくちゃ時間かかるので、
-dをつけずにupして立ち上がったのを確認してからアクセスすると良い）

* `docker-compose exec web bash`でコンテナに入る

# 次回以降
* `docker-compose up -d`

# gem変更時、package.json更新時
* `docker-compose run bundle install`
* `docker-compose run yarn install`
これをup前にやらないと起動しない。
