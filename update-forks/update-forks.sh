#!/bin/bash
FORKS_ROOT="${FORKS_ROOT:-$HOME/forks}"

for D in `find "$FORKS_ROOT" -mindepth 1 -maxdepth 1 -type d`
do
	cd "${D}"
	git fetch -p -P -t
	git pull
	for i in `git branch -a | grep remote | grep -v HEAD`; do git branch --track ${i#remotes/origin/} $i; done
	git push --all --follow-tags -f
	git gc --auto
done
