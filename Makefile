SHELL := /bin/bash

all:
	@python3 build.py && git add -A && git commit -m wip && git push origin master
	
build:
	@python3 build.py

deploy:
	@git add -A && git commit -m wip && git push origin master
