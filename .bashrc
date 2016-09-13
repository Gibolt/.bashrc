# Thomas Reese's common .bashrc script

alias bashrc="source ~/.bashrc"
alias vb="vim ~/.bashrc && source ~/.bashrc" # Edit .bashrc in vim, and immediately load changes
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias apt-get="sudo apt-get"
alias c="clear"
alias ~="cd ~"
alias mkdir="mkdir -pv"
alias path="echo -e ${PATH//:/\\n}"
alias svim="sudo vim"
alias less="less -r"

alias h="history"
alias hg="history | grep"
alias myip="curl http://ipecho.net/plain; echo"

alias ls="ls -F --color --show-control-chars"
alias ll="ls -la"

alias gs="git status"
alias gw="git show"
alias gb="git branch"
alias gc="git commit"
alias gca="git commit --amend"
alias gcm="git commit -m"
alias ga="git add"
alias qga="git add" # In case I make a typo
alias gd="git diff"
alias qgd="git diff"
alias go="git checkout"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gom="git checkout master"
alias gcom="git checkout master"
alias gp="git push --follow-tags"
alias gpr="git pull --rebase"
alias gst="git stash"
alias gsa="git stash apply"
alias gk="gitk --all&"
alias grc="git rebase --continue"
alias grs="git rebase --skip"
alias cg="cd /c/Git" # Change to your main Git project directory
alias gbm="git branch --merged"
alias gbn="git branch --no-merged"
alias gbu="git branch --no-merged"
alias grm="git rebase master"

gitlog () {
    git log -S $1 --source --all;
}

# Show a list of all current branches and if they can be safely deleted
alias gbb="echo '   -----  Merged Branches  -----' && git branch --merged && echo '' && echo '   ----- Unmerged Branches -----' && git branch --no-merge"

alias gl="git log -n 5"
alias gln="git log -n"
alias gsno="git show --pretty='format:' --name-only"
alias gsn="git show --name-only -n 3"

gitpushgo () {
    rebaseBranch=$1;
    if [ $# -eq 0 ]; then
        rebaseBranch=$(git symbolic-ref --short HEAD);
    fi	
    printf "\n    ----- Auto-Merging $rebaseBranch -----\n";
    printf "\n    ----- Stashing old commit -----\n";
    git stash;
    printf "\n    ----- Checkout Master -----\n";
    git checkout master &&
    printf "\n    ----- Rebase Master -----\n";
    git pull --rebase &&
    printf "\n    ----- Checkout $rebaseBranch -----\n";
    git checkout $rebaseBranch &&
    printf "\n    ----- Rebase $rebaseBranch from Master -----\n";
    git rebase master &&
    printf "\n    ----- Checkout Master -----\n";
    git checkout master &&
    printf "\n   ----- Push $rebaseBranch and Master -----\n";
    git merge $rebaseBranch && git push && git stash apply;
}

gdb () {
    deleteBranch=$1;
    if [ $# -eq 0 ]; then
        deleteBranch=$(git symbolic-ref --short HEAD);
    fi	
    printf "\n   ----- Deleting Branch $deleteBranch -----\n";
    printf "\n   ----- Checkout Master Branch -----\n"; 
    git checkout master &&
    printf "\n" &&
    git branch -d $deleteBranch;
}

gittag () {
    revision=$1;
    printf " ----- Committing with tag annotation v$revision -----\n";
    git commit -m "Bumping version to $revision" &&
    git tag -a v$revision -m "Release $revision";
}
