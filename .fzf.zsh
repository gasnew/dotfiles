# Setup fzf
# ---------
if [[ ! "$PATH" == */home/gnew/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/gnew/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/gnew/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/gnew/.fzf/shell/key-bindings.zsh"
