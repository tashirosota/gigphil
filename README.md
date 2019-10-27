# README
気合

# rails server 起動までの方法
* Ruby 2.6.4をインストール
* PostgreSQL（psql(PostgreSQL) 11.5 で動作確認済み）をインストール
* `bin/setup` を実行
  * `bundle install`, `yarn install`, `rails db:prepare` などを実行します
  * `bundle exec rails db:drop db:create db:migrate musicbar:create_initial_data musicbar:scraping_all`
