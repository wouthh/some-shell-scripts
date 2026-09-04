# update-forks

Updates your forked repositories in for example GitHub.

# Usage

The script scans `$HOME/forks` by default. Set `FORKS_ROOT` to the directory
containing your local fork checkouts.

Then set the correct origin branch to fetch for each cloned repository in the forks dir :
`git remote set-url origin https://github.com/example-owner/upstream-repository.git`

And reset where to push to :
`git remote set-url --push origin https://github.com/example-owner/fork-repository.git`

Check if everything is okay :
`git remote -v`

In my case I got for example
```
$ git remote -v
origin	https://github.com/example-owner/upstream-repository.git (fetch)
origin	https://github.com/example-owner/fork-repository.git (push)
```

Now you can use this script (or launch it via cron / anacron like I do)
