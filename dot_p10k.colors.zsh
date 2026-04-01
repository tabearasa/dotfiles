# Catppuccin-inspired color overrides for Powerlevel10k
#
# Sourced AFTER ~/.p10k.zsh to override wizard-default colors.
# Run `p10k configure` freely to change style — colors are preserved here.
#
# To preview the 256-color palette:
#   for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done

# Frame / ornament color (242 = softer gray)
typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND=242

# Patch frame prefix/suffix color to 242, preserving wizard-generated characters
for _p10k_color_var in POWERLEVEL9K_MULTILINE_{FIRST,NEWLINE,LAST}_PROMPT_{PREFIX,SUFFIX}; do
  if [[ -n ${(P)_p10k_color_var} ]]; then
    typeset -g $_p10k_color_var="${(P)_p10k_color_var/\%<->F/%242F}"
  fi
done
unset _p10k_color_var

# OS icon
typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=215   # warm orange

# Directory (mauve background, dark text)
typeset -g POWERLEVEL9K_DIR_BACKGROUND=183
typeset -g POWERLEVEL9K_DIR_FOREGROUND=237
typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=237
typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=237

# VCS / git status (pastel greens and warm yellows)
typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=151
typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=223
typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=151
typeset -g POWERLEVEL9K_VCS_CONFLICTED_BACKGROUND=223
typeset -g POWERLEVEL9K_VCS_LOADING_BACKGROUND=237

# Status indicators
typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=151
typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=151
typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=237
typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=211
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND=237
typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_BACKGROUND=211
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND=237
typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_BACKGROUND=211

# Command execution time (dark text on pink)
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=237
typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=211
