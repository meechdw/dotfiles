alias cd="z"
alias vi="nvim"
alias vim="nvim"
alias ls="ls --color"
alias lf="ls --color=never -a | fzf"
alias lg="lazygit"

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions

setopt APPEND_HISTORY
setopt SHARE_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY

source <(fzf --zsh)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/src/dev-tools/bin:$PATH"
export PATH="$HOME/src/infrastructure/bin:$PATH"

export GOPRIVATE="bitbucket.org/wieckmedia/*"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

[ -s "/Users/mitchell/.bun/_bun" ] && source "/Users/mitchell/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

ln -sfn "$(brew --prefix llvm)/bin/clang-format" "$HOME/.local/bin/clang-format"
ln -sfn "$(brew --prefix llvm)/bin/clang-tidy" "$HOME/.local/bin/clang-tidy"

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
