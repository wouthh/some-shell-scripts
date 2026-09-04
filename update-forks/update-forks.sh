#!/bin/bash
FORKS_ROOT="${FORKS_ROOT:-$HOME/forks}"

if ! FORKS_ROOT="$(cd "$FORKS_ROOT" && pwd -P)"; then
	echo "Unable to access FORKS_ROOT" >&2
	exit 1
fi

while IFS= read -r -d '' D; do
	cd "$D" || continue
	git fetch -p -P -t
	git pull
	for i in `git branch -a | grep remote | grep -v HEAD`; do git branch --track ${i#remotes/origin/} $i; done
	git push --all --follow-tags -f
	git gc --auto
done < <(find "$FORKS_ROOT" -mindepth 1 -maxdepth 1 -type d -print0)
