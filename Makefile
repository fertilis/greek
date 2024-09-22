SHELL := /bin/bash

all:
	@python3 build.py && git add -A && git commit --amend --no-edit && git push -f origin master
	
build:
	@python3 build.py

deploy:
	@git add -A && git commit -m wip && git commit --amend --no-edit && git push -f origin master
