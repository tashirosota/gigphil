.DEFAULT_GOAL := usage

up:
	docker-compose up -d

up-logs:
	docker-compose up

build:
	docker-compose build

down:
	docker-compose down

logs:
	docker-compose logs -f

bash:
	docker-compose exec web /bin/sh

rubocop:
	docker-compose exec web bundle exec rubocop -a

routes:
	docker-compose exec web bundle exec rake routes

annotate:
	docker-compose exec web bundle exec annotate

tasks:
	docker-compose exec web bundle exec rake tasks

test:
	docker-compose exec web bundle exec rspec

usage:
	@echo usage: [build, up, up-logs, down, logs, bash, rubocop, routes, annotate, tasks, brakeman, test, watch]
