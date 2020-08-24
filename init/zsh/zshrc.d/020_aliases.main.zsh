# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#                      $ZDOT/zshrc.d/020_aliases.main.zsh                         |
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
# File :  ${ZDOT}/zshrc.d/020_aliases.main.zsh
# sourced from  /etc/zshrc
# Version : 2.0.0
# Main aliases start here. You will probably want to edit this.
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                     TODO
#---------------------------------------------------------------------------------
# 19/07/2019 :
# • Test portability of new alias on linux
# 17/02/2020 :
# • Test expand_aliases
# • Better stucturing.

#---------------------------------------------------------------------------------
#                                    CHANGES
#---------------------------------------------------------------------------------
# 23/10/2017 :
# • Remove command variables to be portable with linux.
# 28/10/2017 :
# • Remove the grep --color=auto option on filetree alias to be portable with linux.
# 19/07/2019 :
# • Add new alias
# 17/02/2020 :
# • Add expand_aliases fct.
# 20/02/2020 :
# • Add alias -g RCOL.Good for : echo ${(k)functions} RCOL

#---------------------------------------------------------------------------------
#                                     CONFIG
#---------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------
if [[ -o interactive ]]; then
 ##uncomment to debug
 # {{{ Loading status
 zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
 #}}}

 # {{{ Loading status
 zshrc_load_status () { echo "${YEL}  + Main aliases load:${GREY} $*${NC}"}
 #}}}

   ## Afin de ne pas oublier la commande qui se cache derrière un alias, les alias
   # explicite la font s’afficher comme si elle avait été entrée juste après l’alias.
   # Voici le code à rajouter dans votre .zshrc (le fichier de config que zsh charge
   # avant chaque session) pour activer les alias explicites:

    preexec_functions=()
    function expand_aliases {
        input_command=$1
        expanded_command=$2
        if [ $input_command != $expanded_command ]; then
            print -nP $PROMPT
            echo $expanded_command
        fi
    }
    preexec_functions+=expand_aliases
    # ------------------------------------------------------------------------------
    #                                                                               \
    # --------------------------------------------------------------------------------
    #                  COMMON TERMINAL COMMAND ALIAS                                  |
    # -------------------------------------------------------------------------------

    # if [[ -x $SWPREFIX/bin/ls ]] ||  [[ $IS_MAC ]] && [[ ! $IS_FREEBSD ]]; then
    [[ $IS_MAC ]] && alias ls='command ls -G'

    [[ $IS_LINUX ]] && alias ls='command ls --color=auto'

    ###############################################################################
    ###############################################################################
    # ------------------------------------------------------------------------------
    #                                                                               \
    # --------------------------------------------------------------------------------
    #                        ADMIN DAILYCOMMAND ALIAS                                |
    # --------------------------------------------------------------------------------
    ######## CD COMMAND
     # Easier navigation: .., ..., ...., ....., ~ and -
    alias ..="cd .."
    alias ...='cd ../..'
    alias ....="cd ../../.."
    alias .....="cd ../../../.."
    alias ~="cd ~" # `cd` is probably faster to type though
    alias -- -="cd -"
    alias owd='cd "$OLDPWD"'

    ####### CP COMMAND
    alias cp='command cp -i'
    #alias orig='$(cp $@{,.orig})'

    ######## MV COMMAND
    alias mv='command mv -i'

    ######## RM COMMAND
    alias rm='command rm -i' # Some people hate this, but it saved my arse many times.
    alias rf='command rm -Rf'

    ######## DU COMMAND
    alias 'dus=du -sckx * | sort -nr' #directories sorted by size

    ######## TAR COMMAND
    ### COMPRESS
    # alias gz='command tar -czvf'
    # alias bz2='command tar -cjvf'
    # alias xz='command tar -cJvf'

    ######## MKDIR COMMAND
    # -> Prevents accidentally clobbering files.
    alias mkdir='command mkdir -p'

    ######## LS COMMAND
    alias filetree="command ls -R | command grep ":$" | command sed -e 's/:$//' -e 's/[^-][^/\]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
        # Do we have GNU ls with color-support
    if [[ "$TERM" != dumb ]]; then
            alias cla='command clear && ls -Al '
            alias clo='command clear && ls -lO '
            alias cdla='command cd   && command clear && ls -Al '
            ##a1# List files with colors (\kbd{ls -F \ldots})
             #alias ls='command ls -hF '                               ##a1# List all files, with colors (\kbd{ls -la \ldots})
            alias l='ls -lF '
            alias la='ls -Al '                                 # show hidden files
            alias lc='ls -ltcr '                               # sort by and show change time, most recent last
            alias lk='ls -lSr '                                # sort by size, biggest last
            alias lal='ls -altr '
            alias ll='ls -ltr '
            alias ldir='ls -d */'
            alias lh='ls -hAl '                                ##a1# List files with long colored list, append qualifier to filenames (\kbd{ls -lF \ldots})\\&\quad(\kbd{/} for directories, \kbd{@} for symlinks ...)
            alias lm='ls -al | more '                          # pipe through 'more'
            alias lsa='ls -AFlh'
            alias lsd='ls -AFldh '                             # list dirs only
            alias lsc='command clear && ls -al '
            alias lst="ls -R | command grep ":$" | command sed -e 's/:$//' -e 's/[^-][^/\]*\//--/g' -e 's/^/ /' -e 's/-/|/'"                                                  ##a1# List files with long colored list, without dotfiles (\kbd{ls -l \ldots})
            alias lt='ls -ltr '                                # sort by date, most recent last
            alias lu='ls -ltur '                               # sort by and show access time, most recent last
            alias lg='ls -l --group-directories-first '
            alias lx='ls -lXB '                                # sort by extension #not work on os X
            alias tree='tree -Csu'
        else
            alias clo='command clear && ls -lO'
            alias cdla='command cd && command clear && ls -Al'
            alias l='ls -lF'
            alias la='ls -Al'                                  # show hidden files
            alias lal='ls -altr'
            alias ldir='ls -d .*'                                      # show hidden files/directories only
            alias ldirn="ls -ld *(/om[1])"                                                            # pipe through 'more'
            alias lh='ls -hAl'                                 ##a1# List files with long colored list, append qualifier to filenames (\kbd{ls -lF      \ldots})\\&\quad(\kbd{/} for directories, \kbd{@} for symlinks ...)
            alias lm='ls -al | more'
            alias lll='ls -GFhl'                               # Same as above, but in long listing format
            alias ll='ls -GFh'                                 # Colorize output, add file type indicator, and put sizes in human readable format
            alias lsd='ls -aFldh'                              # list dirs only
            alias lst="ls -R | command grep ":$" | command sed -e 's/:$//' -e 's/[^-][^/\]*\//--/g' -e 's/^/ /' -e 's/-/|/'"                                                  ##a1# List files with long colored list, without dotfiles (\kbd{ls -l \ldots})"]'"
            alias lu='ls -ltur'                                # sort by and show access time, most recent last
            alias lt='ls -ltr'                                 # sort by date, most recent last

            # etc "
    fi

    #-------------------------------------------------------------
    # spelling typos - highly personnal and keyboard-dependent :-)
    #-------------------------------------------------------------
    ## global aliases (for those who like them) ##
    alias -g BG='& builtin exit'
    alias -g C='| command wc -l'
    alias -g CA="2>&1 | command cat -A"
    alias -g D="DISPLAY=:0.0"
    alias -g DN=/dev/null
    alias -g ED="builtin export DISPLAY=:0.0"
    alias -g EG='|& command egrep'
    alias -g H='|& command head'
    alias -g EL='|& command less'
    alias -g ELS='|& command less -S'
    alias -g ETL='|& command tail -20'
    alias -g ET='|& command tail'
    alias -g F=' | command fmt -'
    alias -g G='| command egrep'
    alias -g H='| command head'
    alias -g Hl=' --help |& command less -r'
    alias -g HL='|& command head -20'
    alias -g Sk="*~(*.bz2|*.gz|*.tgz|*.zip|*.z)"
    alias -g LL="2>&1 | command less"
    alias -g L="| command less"
    alias -g LS='| command less -S'
    # alias -g MM='| most'
    alias -g M='| command more'
    alias -g N='&>/dev/null'
    alias -g NE="2> /dev/null"
    alias -g NS='| command sort -n'
    alias -g NUL="> /dev/null 2>&1"
    alias -g PIPE='|'
    alias -g R='| command tr A-z N-za-m'
    alias -g RCOL="| tr ' ' '\n' | sort -u | column" # Good for : echo ${(k)functions} RCOL
    alias -g RNS='| command sort -nr'
    alias -g S='| command sort'
    alias -g SL='| command sort | command less'
    alias -g TL='| command tail -20'
    alias -g T='| command tail'
    alias -g US='| command sort -u'
    alias -g VM=/var/log/messages
    alias -g X0G='| command xargs -0 egrep'
    alias -g X0='| command xargs -0'
    alias -g XG='| comand xargs egrep'
    alias -g X='| command xargs'
    alias -g V='| command vim -'

    ######## DU COMMAND
    alias du='command du -kh'       # Makes a more readable output.

    ######## GREP COMMAND
    #alias igrep='command grep -i'
    #alias grep='command grep -G'
    alias rgrep='command grep -r'

    ######## PS COMMAND
    #alias psall='command ps -aux'
    alias psa='command ps auxww'
    alias psf='command ps auxwww'
    #alias psfo='command ps --forest -eo pid,ppid,cmd'
    alias pstoz='command ps -x'
    alias psopc='command ps -xo pid,cmd 2>dev/null'
    alias psda='command ps -axww'
    alias psl='command ps -alxww'
    alias psj='command ps -axjww'
    alias pso='command ps -axwwo uid,pid,ppid,pgid,pri,nice,state,time,%cpu,%mem,command'
    ## get top process eating memory
    alias psmem='command ps aux | command sort -nr -k 4'
    alias psmem10='command ps aux | command sort -nr -k 4 | command head -10'
    ## get top process eating cpu ##
    alias pscpu='command ps aux | command sort -nr -k 3'
    alias pscpu10='command ps aux | command sort -nr -k 3 | command head -10'

    ######## TYPE COMMAND
    alias which='builtin type -a'

    ######## TOP COMMAND
    alias cpu='command top -o %cpu'
    alias mem='command top -o rsize' # memory

    ######## CHMOD COMMAND
    alias chmox='command chmod +x'

    ######## CLEAR COMMAND
    alias cl='command clear'

    ######## DATE COMMAND
    alias nowtime='command date +"%T"'
    alias nowdate='command date +"%d-%m-%Y"'
    ######
    alias h='builtin history'
    alias jb='builtin jobs -l'

    ####### TAIL COMAAND
    alias ftail='command tail -f'
    # Start calculator with math support
    alias bc='command bc -l'
    alias fail='builtin printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"'
    alias ok='builtin printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"'

    ###############################################################################
    ###############################################################################
    # ------------------------------------------------------------------------------
    #                                                                               \
    # --------------------------------------------------------------------------------
    #                                NET/SERVEUR ALIAS                                |
    # --------------------------------------------------------------------------------
    # If your version of 'ls' doesn't support --group-directories-first try this:
    # function ll(){ ls -l "$@"| egrep "^d" ; ls -lXB "$@" 2>&-| \egrep -v "^d|total "; }
    alias wget='command wget -c'

    ###############################################################################
    ###############################################################################
    # ------------------------------------------------------------------------------
    #                                                                               \
    # --------------------------------------------------------------------------------
    #                               DEV ALIAS                                         |
    # --------------------------------------------------------------------------------
    # compile_clean: cleanup after failed compile
    alias compile_clean='command make clean; command rm config.log config.status config.h stamp-h config.cache'
    # --------------------------------
    #                                 \
    # ---------------------------------
    #          MOZCORE_DEBUG          |
    # ---------------------------------
    ##
    # uncomment for debugging
    zshrc_primary_load_status "Main aliases set."
fi
