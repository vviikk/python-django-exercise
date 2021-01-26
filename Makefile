#!/usr/bin/make

SHELL = /bin/sh

UID := $(shell id -u)
GID := $(shell id -g)

export UID
export GID

help:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

install:
	pipenv install

activate:
	source ${PWD}/venv/bin/activate

start:
	python ${PWD}/app/manage.py runserver 0.0.0.0:8000

migration:
	python ${PWD}/app/manage.py makemigrations

migrate:
	python ${PWD}/app/manage.py migrate

superuser:
	python ${PWD}/app/manage.py createsuperuser

test:
	pushd app; python manage.py test && flake8; popd;

test-docker:
	docker-compose run app sh -c "python manage.py test && flake8"

push:
	git push origin master

deploy:
	docker-compose build
	docker-compose up -d

down:
	docker-compose down