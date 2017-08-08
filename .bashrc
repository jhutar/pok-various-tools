# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias grep='grep --color=tty'   # http://udrepper.livejournal.com/17109.html

# Mine favourite typo
alias tasks='task'

alias cvs-add='cvs add'
alias cvs-commit='cvs commit'
alias cvs-diff='cvs diff -u | cdiff'
alias cvs-remove='cvs remove'
alias cvs-status='cvs status'
alias cvs-tag='cvs tag'
alias cvs-update='cvs update -d -P'

alias svn-add='svn add'
alias svn-commit='svn commit'
alias svn-diff='svn diff | cdiff'
alias svn-remove='svn remove'
alias svn-status='svn status'
alias svn-update='svn update'

alias git-add='git add'
alias git-commit='git commit'
alias git-push='git push'
alias git-pull='git pull --rebase'
alias git-diff='git diff'
alias git-rm='git rm'
alias git-checkout='git checkout'
alias git-branch='git branch'
alias git-status='git status'

alias git-pp='git-pull --rebase && git-push'

alias yum='dnf'

function cdg(){
	cd ~/Checkouts/GIT/
	clear
	[ -n "$1" ] && cd "$1"
}

# Make history bigger
export HISTSIZE=50000
