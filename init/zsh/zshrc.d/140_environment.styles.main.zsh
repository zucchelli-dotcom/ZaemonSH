# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#              $ZDOT/zshrc.d/140_environment.styles.main.zsh                      |
#                                                                                 |
# --------------------------------------------------------------------------------
#########################################################################
#                                                                       #
#  ZaemonSH created by :                                                #
#  Zucchelli Bryan && @N@TOME && Admiral Gr@ss H0pper on Oct 13, 2016.  #
#  Copyright (c) 2020. All rights reserved.                             #
#  Inspired by zsh-templates-osx created by :                           #
#  William Scott on May 11, 2007.                                       #
#  Copyright (c) 2007. All rights reserved.                             #
#                                                                       #
#  This program is free software; you can redistribute it               #
#  and/or modify it under the terms of the GNU General Public License   #
#  as published by the Free Software Foundation; either version 2       #
#  of the License, or (at your option) any later version.               #
#                                                                       #
#  This program is distributed in the hope that it will be useful,      #
#  but WITHOUT ANY WARRANTY ; without even the implied warranty         #
#  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.              #
#  See the GNU General Public License for more details.                 #
#                                                                       #
#  You should have received a copy of the GNU General Public License    #
#  along with this program ; if not, write to :                         #
#  The Free Software Foundation,Inc.                                    #
#  51 Franklin Street, Fifth Floor                                      #
#  Boston,  MA 02110-1301 USA                                           #
#                                                                       #
#  cf. URL:   http://www.fsf.org/licensing/licenses/gpl.html            #
#                                                                       #
#########################################################################

# --------------------------------------------------------------------------------
# File:  $ZDOT/zshrc.d/140_environment.styles.main.zsh
# sourced from /etc/zshrc
# Version: 2.0.0
# Most of what follows is distributed with ZSH
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                     CHANGES
#---------------------------------------------------------------------------------
# 11/05/2019 :
# • William Scott create this one.

# 16/07/2019 :
# • Add style completion.

#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------

###################################################################################
###################################################################################
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                           MAIN ENVIRONNEMENT STYLE                             |
# --------------------------------------------------------------------------------
 if [[ -o interactive ]]; then
        ##uncomment to debug
        # {{{ Loading status
            zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
        #}}}

        # {{{ Loading status
            zshrc_load_status () { echo "${YEL}  + Environment main stylel load:${GREY} $*${NC}"}
        #}}}


    # General completion technique
 # zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
 zstyle ':completion:*' special-dirs true
 zstyle ':completion:*:warnings' format 'No matches: %d'
 zstyle ':completion:*:cd:*' ignore-parents parent pwd # cd will never select the parent directory (e.g.: cd ../ <TAB>):
 zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
 zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
 zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
 zstyle ':completion:*:apropos:*' separate-sections true
 zstyle ':completion:*:manuals' separate-sections true
 zstyle ':completion:*:descriptions' format '%F{GREENB}%B%d%b'
 zstyle ':completion:*:messages' format '%F{GREENB}%d'
 zstyle ':completion:*:warnings' format '%F{RED}No matches for: %d'
 zstyle ':completion:*:windows' menu on=1
 #zstyle -d ':completion:*:windows' menu
 zmodload zsh/complist
 zstyle ':completion:*' expand prefix suffix
 ###Szstyle ':completioechn::*:::' completer _complete _prefix add-space true
 zstyle ':completion:*:prefix:*' add-space true
 zstyle ':completion:::::' completer _complete _approximate
 #zstyle ':completion:*:approximate:*' max-errors 2

 #One error for every three characters
 zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

 #zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
 zstyle ':completion:*:expand:*' accept-exact true

 # ## another different completer setting: expand shell aliases
 zstyle ':completion:*' completer _expand_alias _complete _approximate
 zstyle ':completion:*' completer _expand_shell_function _complete _approximate
 zstyle ':completion:*' completer _expand_builtin_command _complete _approximate
 zstyle ':completion:*' completer _expand_external_command _complete _approximate
 #to group the different types of command together, separately
 #from parameters (zsh’s terminology for variables), you could do this:
 # zstyle ':completion:*:-command-:*:(commands|builtins|reserved-words|aliases)' group-name commands




#zstyle ':completion:*' completer _complete _correct _approximate _prefix
    # changed completer settings
    zstyle ':completion:*' completer _complete _correct _approximate
    # zstyle ':completion:*' completer _complete _prefix
    zstyle ':completion::prefix-1:*' completer _complete
    zstyle ':completion:incremental:*' completer _complete _correct
    zstyle ':completion:predict:*' completer _complete

    # man zshcontrib
    zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5} [%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
    zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
    zstyle ':vcs_info:*' enable git #svn cvs

    # Completion caching
    zstyle ':completion:*' accept-exact '*(N)'
    zstyle ':completion::complete:*' use-cache 1
    zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST


    # Case-insensitive (all), partial-word, and then substring completion.
    if zstyle -t '::completion:*' case-sensitive; then
       zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
       setopt CASE_GLOB
    else
       zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
       unsetopt CASE_GLOB
    fi

    # Make the list prompt friendly
    zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

    # Make the selection prompt friendly when there are a lot of choices
    zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

    # Add simple colors to kill
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a- z-]#)*=01;34=0=01'

    # list of completers to use
    zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

    zstyle ':completion:*' menu select=1 _complete _ignored _approximate

    # offer indexes before parameters in subscripts
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    # formatting and messages
    zstyle ':completion:*' verbose yes
    # Describe each match group.
    zstyle ':completion:*:descriptions' format "%B---- %d%b"
    # zstyle ':completion:*:descriptions' format '%B%d%b'
    # zstyle ':completion:*:descriptions' format '%F{yellow}%B%d%b'

    zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
    zstyle ':completion:*' group-name ''

    # ignore completion functions (until the _ignored completer)
    zstyle ':completion:*:functions' ignored-patterns '_*'

    # Expand partial paths
    zstyle ':completion:*' expand 'yes'
    zstyle ':completion:*' squeeze-slashes 'yes' ## If you end up using a directory as argument, this will remove    the trailing slash (usefull in ln)

    # Include non-hidden directories in globbed file completions
    # for certain commands
    #zstyle ':completion::complete:*' \
    #  tag-order 'globbed-files directories' all-files
    #zstyle ':completion::complete:*:tar:directories' file-patterns '*~.*(-/)'

    # Don't complete backup files as executables
    zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

    # Separate matches into groups
    zstyle ':completion:*:matches' group 'yes'

    # Describe options in full
    zstyle ':completion:*:options' description 'yes'
    zstyle ':completion:*:options' auto-description '%d'
    zstyle ':completion:*' auto-description 'specify: %d'
    # }}}

    # {{{ Simulate my old dabbrev-expand 3.0.5 patch
    zstyle ':completion:*:history-words' stop yes
    zstyle ':completion:*:history-words' remove-all-dups yes
    zstyle ':completion:*:history-words' list false
    zstyle ':completion:*:history-words' menu yes
    # }}}

    zshrc_load_status 'miscellaneous'

    # {{{ ls colours
    if which dircolors >&/dev/null && [[ -e "${zdotdir}/.dircolors" ]]; then
      # show directories in yellow
      #eval `dircolors -b $zdotdir/.dircolors`
      noglob eval $(command dircolors -b $zdotdir/.dircolors)
    fi

    if [[ $ZSH_VERSION > 3.1.5 ]]; then
      zmodload -i zsh/complist

      zstyle ':completion:*' list-colors ''

      zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

      # completion colours
      zstyle ':completion:*' list-colors "$LSCOLORS"
      # zstyle ':completion:*' list-colors ${GREEN}
    fi

    # }}}
    # }}}
    # --------------------------------
    #                                 \
    # ---------------------------------
    #         ZEAMONSH-DEBUG           |
    # ---------------------------------
    ##
    # uncomment for debugging
    zshrc_primary_load_status "Environment main styles set."
fi
