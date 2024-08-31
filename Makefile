SHELL := /bin/bash

all:
	@bash build.sh && git add -A && git commit -m wip && git push origin master
	
build:
	@bash build.sh
