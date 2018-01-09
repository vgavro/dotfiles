[[ $- != *i* ]] && return
if command -v fish 2>/dev/null; then
   exec fish
fi
