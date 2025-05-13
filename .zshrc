alias cd="z"
alias vi="nvim"
alias vim="nvim"

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
SAVEHIST=5000
HISTSIZE=4999
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY

source <(fzf --zsh)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

for key in $(security dump-keychain | grep ENV_ | awk -F'=' '{print $2}' | tr -d '"' | sort -u); do
  export ${key#ENV_}="$(security find-generic-password -s "$key" -w)"
done
