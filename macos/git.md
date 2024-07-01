# git

## GitHub アカウントへの新しい SSH キーの追加

- [新しい SSH キーを生成して ssh-agent に追加する](https://docs.github.com/ja/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [[GitHub アカウントへの新しい SSH キーの追加](https://docs.github.com/ja/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)]

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
touch ~/.ssh/config
```

modify `config`

```
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```

```sh
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

## git config

- config would be stored as `~/.config/git/config`

```
[user]
	name = MyName
	email = me@gmail.com
[color]
	ui = auto
[core]
	editor = vim
	excludesfile = /Users/home/.config/git/ignore
[alias]
	# GIT_UPSTREAM should be set like `upstream/master`, `origin/master`
	# sample
	sample = "!f(){ upstream=${GIT_UPSTREAM:-origin/master}; echo $upstream;};f"

	# alias
	al = config --get-regexp alias # show git alias list

	# status
	st = status

	# branch (Note: some of alias are used in other alias)
	br = branch
	bra = branch -a # show all branches
	tb = rev-parse --abbrev-ref --symbolic-full-name @{u} # show upstream branch name
	cb = rev-parse --abbrev-ref HEAD # show current branch name
	brn = "!f(){ git branch | head -n $1 | tail -n 1;};f" # `git brn 1` get `n`th branch name from the top in branch list
	brdn = "!f(){ brname=$(git branch | head -n $1 | tail -n 1); git branch -D $brname;};f" # `git brdn 1` delete branch by number in branch list

	# checkout
	ch = checkout
	chnew = "!f(){ git ch -b $1 $2;};f" # `git chnew branch-name origin/base-branch` create new branch
	chn = "!f(){ brname=$(git branch | head -n $1 | tail -n 1); git checkout $brname;};f" # `git chn 1` change curent branch to index of list
	chtag = checkout -b $1 refs/tags/$1 $ chtag tag-name

	# add
	#addu = "!f(){ git diff --name-only --diff-filter=M | xargs git add;};f" # git add files without untracked files (= git add -u)
	addu = add -u

	# commit
	cm = commit -m       # commit with message
	cmsign = commit --signoff -m # commit with signoff
	cmgpg = commit -S -m # GPG-sign commits
	coam = "!f(){ git commit -am \"$1\";};f" # `coam message` commit with add all modified files and message

	# fetch
	ft = fetch origin
	fta = fetch --all
	clnf = fetch -p # Before fetching, remove any remote-tracking references those no longer exist on the remote

	# push
	#pushforce = push --force-with-lease # push with safe push (recommended)
	puc = "!f(){ br=$(git cb);git push origin \"${br}\";};f"     # get current branch name, and push there.
	pucu = "!f(){ br=$(git cb);git push -u origin \"${br}\";};f" # get current branch name, and push there with setting upstream
	pucf = "!f(){ br=$(git cb);git push --force-with-lease origin \"${br}\";};f" # get current branch name, and push there with force

	# reset
	canadd = reset HEAD # `git canadd filename` cancel files by git add、`git candd` cancel all files
	rs = reset --soft HEAD~ # reset commit and add action
	rscurrent = "!f(){ tb=$(git tb); git reset --hard $tb;};f" # git reset by current upstream branch
	recm = "!f(){ cmt=$(git log -n 1 --pretty=format:%s);git reset --soft HEAD~;git commit -am \"${cmt}\";};f" #reset and commit with same message again.

	# rebase
	rb = "!f(){ git fta; git rebase $1;};f" # `rb merge-target-branch` this rebase means trying to marge from merge-target-branch

	# remove
	rmcached = rm --cached # leave files, but exclude that file from git management.
	clnchk = clean -dn # remove untracked files and directories but `n` means dry-run
	clnok = clean -fd # remove files, but make sure by git clnchk in advance
	clnchk2 = clean -dnx # remove Remove untracked files and directories including files set in .gitignore but `n` means dry-run
	clnok2 = clean -fdx # remove files, but make sure by git clnchk2 in advance

	# log
	lg = log --oneline --graph --decorate # show log with oneline
	lastlog = log -1 HEAD # show latest log
	lastmsg = log -n 1 --pretty=format:\"%s\" # show latest commit message
	lastcmtid = log -n 1 --pretty=format:\"%H\" # show latest commit id ($git rev-parse HEAD)

	# log file content
	showhis = "!f(){ id=$(git log -n $1 --pretty=format:%h);git show ${id};};f" # `git showhis 1` => show latest modification of code
	deletelist = log --diff-filter=D --summary # show deleted file history in git log
	# log useful
	pushedor = "!f(){ br=$(git cb); git log origin/$br..$br;};f" # get current branch and make sure if current branch has already been pushed

	# submodule
	updsub = submodule update --init --recursive

	# diff
	diffadd = diff --cached # diff between index and committed file in HEAD

	# remote branches
	remotev = remote -v
	delremote = push --delete origin # delete remote branch

	# worktree
	wt = worktree
	wtlist = worktree list
	wtadd = "!f(){ git worktree add worktree/$1 $1;};f" # `wtadd worktree-name`
	wtrm = "!f(){ rm -rf worktree/$1; git worktree prune;};f" # `wtrm worktree-name`

	# stash
 	stas = stash save
    stap = stash pop

	# other
	nottrace = "!f(){ git update-index --assume-unchanged $1;};f" #　`nottrace file` ignore files like gitignore

[diff]
	tool = vimdiff
[difftool]
	prompt = 0

[filter "lfs"]
	required = true
	clean = git-lfs clean -- %f
	smudge = git-lfs smudge -- %f
	process = git-lfs filter-process
[credential]
	helper = osxkeychain
[pull]
	rebase = false
[url "https://"]
	insteadOf = git://
```
