# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#                   $ZDOT/zshrc.d/021_aliases.additional.zsh                      |
#                                                                                 |
# --------------------------------------------------------------------------------
#########################################################################
#                                                                       #
#  ZaemonSH created by :                                                #
#  Zucchelli Bryan && @N@TOME && Admiral Gr@ss H0pper on Oct 13, 2016.  #
#  Copyright (c) 2029. All rights reserved.                             #
#  Inspired by zsh-templates created by :                               #
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
# File :  ${ZDOT}/zshrc.d/021_aliases.additional.zsh
# sourced from  /etc/zshrc
# Version : 2.0.0
# Additionnal aliases start here. You will probably want to edit this
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------
# 19/07/2019 :
# • Verify portability with linux

#---------------------------------------------------------------------------------
#                                     CHANGES
#---------------------------------------------------------------------------------
# 19/07/2019 :
# • Add new alias
# • rename branch zsh parameters to GITBRANCH
# 19/07/2019 :
# • Problem on ADMINISTRTOR ALIAS with linux : id -p
# 19/07/2019 :
#   Better making an universal isroootoradmin function
# • On linux direct test like  if [[ $(blabla) ]] with redirecting outup to null
#   give bad results. so f [[ $(blabla) 2>/dev/null ]] is better
# 16/12/2019 :
# • group Dot configurations files (ranger vim tmux zsh)
# 2020-02-17 :
# • Add date alias.

#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------
if [[ -o interactive ]]; then
    ##uncomment to debug
    # {{{ Loading status
        zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
    #}}}

    # {{{ Loading status
        zshrc_load_status () { echo "${YEL}  + Universal aliases load:${GREY} $*${NC}"}
    #}}}
    # ------------------------------------------------------------------------------
    #                                                                               \
    # --------------------------------------------------------------------------------
    #                                 COMMON ALIAS                                   |
    # -------------------------------------------------------------------------------
    # Sometimes the zsh correction behavior is irritating:
    alias mkdir='nocorrect mkdir'
    alias mv='nocorrect mv'
    alias cp='nocorrect cp'
    alias touch='nocorrect touch'
    alias ln='nocorrect ln'
    alias ps='nocorrect ps'
    alias ssh='nocorrect ssh'
    alias scp='nocorrect scp'

    # --------------------------------
    #                                 \
    # ---------------------------------
    #   COMMON ADMINISTRATiON  ALIAS   |
    # ---------------------------------
    # Aliases are set to aid in assigning keybindings to terminals spawned from other
    # termianl sessions.
    # rxvt settings to look like aqua (this might be system-dependent)
    if [[ -x $(which rxvt ) ]] && [[ $IS_MAC ]]; then
            alias rxvt='TERM_PROGRAM="rxvt" rxvt -bg black -fg white -cr grey -ls -geometry 80X25 -colorBD yellow -troughColor grey -font 9x15 -sr -scrollColor RoyalBlue3 -internalBorder 5 &'
    elif [[ -x $(which rxvt ) && $ISLINUX  ]];then
            alias rxvt='TERM_PROGRAM="rxvt" rxvt -bg black -fg white -cr grey -ls -geometry 80X25 -colorBD yellow -troughColor grey -font 9x15 -sr -scrollColor RoyalBlue3 &'
    fi
    
    ## ZaemonSH- actions
    alias zc="Z_CorrectSymlinksFunction -d"
    alias zz="builtin exec command zsh"

    # Generate sha1 digest
    alias sha1='command openssl sha1'


    # Stopwatch
    alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

    alias reload="$HOME/.zshrc"
    #### EDITOR
    if [[  $EDITOR == "emacs" ]]; then
     alias enox='emacs -nw'
     alias emw='emacs -nw'
     alias emc='emacsclient -c -a ""'
     alias emt='emacsclient -t -a ""'
    fi
    #### EDIT/SOURCE RC FILES
    if [ $( whence ranger ) ]; then
        alias ra="command ranger"
        local edito="command ranger"

        ## Zsh - configuration
        alias zshrc="$EDITOR ~/.zshrc"

        ## ZaemonSh core configuration alias
        alias Zr="$edito $ZDOT"
        alias Zrc="$edito $P_ZDOTCONFDIR"
        alias Zrco="$edito $P_SYSFCTDIR/core"
        alias Zrda="$edito $P_SYSFCTDIR/darwin"
        alias Zret="$edito $P_SYSFCTDIR/etc"
        alias Zrli="$edito $P_SYSFCTDIR/linux"
        alias Zrun="$edito $P_SYSFCTDIR/universal"
        alias Zrpe="$edito $P_PERSFCTDIR"

        ## Vim configuration alias
        alias vimrc="command $EDITOR ~/.vimrc ~/.vim_runtime/vimrcs/*"
        alias vim_runtime="$edito ~/.vim_runtime"

        # Tmux - configurarion alias
        alias tmuxrc="$EDITOR ~/.tmux.conf"

        ## Ranger configuration files
        alias rangerc="$edito ~/.config/ranger"

       #
        unset edito
    else
        local edito="command $EDITOR"

                ## ZaemonSH- configuration
        alias zshrc="$edito ~/.zshrc"
        
        ## ZaemonSh core configuration alias if ranger isn't on PATH
        alias Zr="$edito $ZDOT"
        alias Zrc="$edito $P_ZDOTCONFDIR"
        alias Zrco="$edito $P_SYSFCTDIR/core"
        alias Zrda="$edito $P_SYSFCTDIR/darwin"
        alias Zret="$edito $P_SYSFCTDIR/etc"
        alias Zrli="$edito $P_SYSFCTDIR/linux"
        alias Zrun="$edito $P_SYSFCTDIR/universal"
        alias Zrpe="$edito $P_PERSFCTDIR"

        # Vim -  configuration alias
        alias vimrc="$edito ~/.vimrc"
        alias vim_runtime="$edito ~/.vim_runtime"
        alias vim_runtime_rc="$edito ~/.vim_runtime/vimrcs"

        # Tmux - configurarion alias
        alias tmuxrc="$edito ~/.tmux.conf"

        ## Ranger configuration files
        alias rangerc="$edito ~/.config/ranger"

        #
        unset edito

   fi

    # --------------------------------
    #                                 \
    # ---------------------------------
    #   COMMON DAILYUSE ALIAS          |
    # ---------------------------------
    ## DATE RELATED
    alias currday="date +%d"
    alias currmon="date +%m"
    alias curryea="date +%Y"
    alias currdate="command date +%d/%m/%Y"
    # Some common aliases:
    alias back='builtin cd "$OLDPWD";pwd'
    # alias rehash='hash -r'        # Now a shell built-in
    alias noguano="command rm -i *~"          # Remove emacs guano
    # Shortcut to the desktop
    [[ $(builtin which dt | command head -n 1 | command awk '{ print $2,$3 }') == "not found" ]] && alias dt="builtin cd $DESKTOP; pwd"    
    # DIR ALIAS
    alias loog='builtin cd /var/log'
    alias etc="builtin cd /etc"
    # Create a new set of commands
    alias path='builtin echo -e $ {PATH//:/\\n}'
    ###### PROCESS
    ## get top 10 shell commands:
    alias top10='builtin print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'
    alias topc='top -o cpu'
    alias topm='top - vsize'
    # Diff
    alias gdiff='command git diff --no-index --color-words '
    # URL-encode strings
    alias urlencode='command python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
    # Intuitive map function
    # For example, to list all directories that contain a certain file:
    # find . -name .gitattributes | map dirname
    alias map="command xargs -n1"
    # Canonical hex dump; some systems have this symlinked
    command -v hd > /dev/null || alias hd="hexdump -C"
    alias mmv='builtin noglob zmv -W'
    # execute last command
    # 'r cc' runs the last command beginning with "cc"
    alias fcs='command fc -s'
    ## edit and source aliases file
    alias va='$EDITOR vi ~/.bash_aliases; source ~/.bash_aliases && echo "aliases sourced"'
    # Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
    # (useful when executing time-consuming commands)
    alias badge="command tput bel"
    alias filetree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^/\]*\//--/g' -e 's/^/ /' -e 's/-/|/'"
    alias filecount='find . -type f | wc -l' # number of files (not directories)
    alias wordy='wc -w * | sort | tail -n10' # sort files in current directory by the number of words they contain
    alias diff2='command diff -y --suppress-common-lines '
    #alias filenotroot='ls -ld /var/*(^u:root)' # All files in /var/ that are not owned by root
    alias fileu+rx="echo *(f:u+rx:) | tr ' ' '\n' | column"
    alias fileu+wxo-x='echo *(f:u+rx,o-x:)'
    zshrc_load_status "Dailyuse aliases set."

    # --------------------------------
    #                                 \
    # ---------------------------------
    #   COMMON NETWORK/SERVERS ALIAS   |
    # ---------------------------------
    # Monitor DNS queries and replies:
    alias monDNS='tshark -Y "dns.flags.response == 1" -Tfields -e frame.time_delta -e dns.qry.name -e dns.a -Eseparator=,'
    # Monitor HTTP queries and replies:
    alias monHTTP='tshark -Y "http.request or http.response" -Tfields -e ip.dst -e http.request.full_uri -e http.request.method -e http.response.code -e http.response.phrase -Eseparator=/s'
    # Monitor x509 certificates on the wire:
    alias monX509Cert='tshark -Y "ssl.handshake.certificate" -Tfields -e ip.src -e x509sat.uTF8String -e x509sat.printableString -e x509sat.universalString -e x509sat.IA5String -e x509sat.teletexString -Eseparator=/s -Equote=d'
    ## ignore ~/.ssh/known_hosts entries
    alias insecssh='command ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" -o "PreferredAuthentications=keyboard-interactive"'
    # fast scp
    alias scp='command scp -o StrictHostKeyChecking=no -c arcfour -o Compression=no'
    alias tcpdump='command su -c "command tcpdump -i eth1"'
    #Control output of networking tool called ping
    # Stop after sending count ECHO_REQUEST packets #
    alias ping='command ping -c 5'
    # Do not wait interval 1 second, go fast #
    alias pingfast='command ping -c 100 -s.2'
    ## Use a default width of 80 for manpages for more convenient reading
    #export MANWIDTH=${MANWIDTH:-80}
    ## instead of global aliase it might be better to use grmls $abk assoc array, whose contents are expanded after pressing ,.
    #$abk[SnL]="| sort -n | less"
    # One of @janmoesen’s ProTip™s
    for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
        alias "$method"="command lwp-request -m '$method'"
    done
    ###### NETSTAT COMMAND
    alias monitor="command netstat | command grep -v localhost | command grep -v stream | command grep -v dgram"
    alias netconns='command netstat -a -f inet'
    alias nettcp_scan='command netstat -ptcp | command grep "ESTABLISHED"'
    alias netudp_scan='command netstat -pudp | command grep "ESTABLISHED"'
    # IP addresses
    alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
    alias localip="ipconfig getifaddr en0"
    alias ips="command ifconfig -a | command grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+      \)\|[a-fA-F0-9:]\+\)' | command awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

    # ciscip: show the ip address of the router
    # replaced with function myip
    # alias ciscip='curl -s http://simple.showmyip.com'
    alias ciscip='myip -r'
    alias myrouter='myip -r'
    alias myairport='myip -r'

    zshrc_load_status "Network/server aliases set."

   # --------------------------------
   #                                 \
   # ---------------------------------
   #       DEVELOPMENT ALIAS        |
   # ---------------------------------
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
   
   ## To demonstrate how a particular command line is broken down into words, we’ll use the
   # printf command. printf allows some text to be output in a specific format. It has the useful
   # feature of reusing the format string if more arguments remain. So if you use a format string
   # such as '%s\n' it will print each word on a new line.
   alias showargs="printf '>>%s<<\n'"
   
   ## GIT SHIT
   if [[ $IS_GIT  ]]; then
        # The rest of my fun git aliaseso
        export GITBRANCH='command git rev-parse --abbrev-ref HEAD'
        alias gl='command git pull --prune'
        alias glog="command git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
        alias gp='command git push origin HEAD'
        alias gd='command git diff'
        alias gc='command git commit'
        alias gca='command git commit -a'
        alias gco='command git checkout'
        alias gcb='command git copy-branch-name'
        alias gb='command git branch'
        alias gs='command git status -sb' # upgrade your git if -sb breaks for you. it's fun.
        alias gall='command git add -A' # Stage all unstaged.
        alias gamend='command git commit --amend -C HEAD' # Use the last commit message and amend your stuffs.
        alias g-track='command git branch $branch --set-upstream-to origin/$branch' # Sets up your branch to track a remote branch. Assumes you mean `origin/$branch-name`.
        alias g-copy-branch-name="builtin echo $branch | command tr -d '\n' | command tr -d ' ' | command pbcopy" # Copy the current branch name to the clipboard.
        #alias g-delete-local-merged="command git branch -d `git branch --merged | command grep -v '^*' | command grep -v 'master' | command tr -d '\n'`" # Delete all local branches that have been merged into HEAD. Stolen from our favorite @tekkub: https://plus.google.com/115587336092124934674/posts/dXsagsvLakJ
        alias g-undo='command git reset --soft HEAD^' # Undo your last commit, but don't throw away your changes
        alias g-unpushed='command git diff origin/$branch..HEAD' # Show the diff of everything you haven't pushed yet.
    fi
    ## GCC
    # Show me all the .c files for which there doesn't exist a .o file.
    alias cwnoo="print *.c(e_'[[ ! -e $REPLY:r.o ]]'_)'"
    
    ## Debug
    zshrc_load_status "Development aliases set."

    # --------------------------------
    #                                 \
    # ---------------------------------
    #       ADMINISTRATOR ALIAS        |
    # ---------------------------------
        #if [[ -n $(/usr/bin/id -p $USER | grep -w admin ) ]]; then
    ## For admin and root user.
    if [[ $IS_ROOT ]] || [[ $IS_ADMIN ]]; then # && [[ -x /usr/bin/sudo || -x /bin/sudo || -x /usr/local/bin/sudo || -x /usr/X11/bin/sudo ]];then
        # If a command is returned complaining of insufficient priviledges, this
        # evocatively-named command executes the previous command string, but now with
        #a sudo prefix:
        ### SUDO
        alias sudo='sudo env PATH=$PATH'
        ####  NETWORK  ####

        ####  ADMINISTRATOR COMMON ALIAS ####
        ### SHUTDOWN/HALT
        alias reb='command sync ; command sync ; command sync ; command sudo command shutdown -r now'
        alias hal='command sync ; command sync ; command sync ; command sudo command halt'
        alias shu='command sync ; command sync ; command sync ; command sudo command shutdown -h now'
        ##### EDIT
	    ########NANO COMMAND
        alias nanos='command sudo command nano'
	    ########VIM COMMAND
        alias vims='command sudo command vim'
        ########CAT
        alias cats='command sudo command cat'
        ####### LS COMMAND
	    alias lns='command sudo command ln'
        ######## LN COMMAND
        alias lss='command sudo command ls'
        ######## CP COMMAND
        alias cps="command sudo command cp"
        ######## CP COMMAND
        alias cprf="command sudo command cp -Rf"
        ######## MV COMMAND
        alias mvs="command sudo command mv -i"
        alias disable="mvs $1 "
        ######## RM COMMAND
        alias rfs="command sudo command rm -Rf"
        ######## MKDIR COMMAND
        alias mkdirs="command sudo command mkdir"
        ######## RM COMMAND
        alias rfs="command sudo command rm -Rf"
        ###
        alias lcas="command clear &&  command sudo command ls -Al"
        alias clos="command clear &&  command sudo command ls -lO "
        ######## GREP COMMAND
        # alias rgreps="command sudo command grep -r --exclude=\q/proc"
        alias greps"command sudo command grep"
        ####   ADMIN DEV COMMAND ALIAS  ####
        # cpan: open the MCPAN shell
        alias cpan="command sudo command perl -MCPAN -e shell"
        ####   NETWORK DEV COMMAND ALIAS  ####
        # cpan: open the MCPAN shell
        alias conns="command sudo command lsof -i"
        # View HTTP traffic
        alias httpdump="command sudo command tcpdump -i en1 -n -s 0 -w - | command grep -a -o -E \"Host\: .*|GET \/.*\""
        alias fu='command sudo $( fc -ln -1)'
        alias sniff="command sudo command ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
        # List open network files:
        alias onf='command sudo  command lsof -ni -P'
        # List contents of various network-related data structures:
        alias vnf='command sudo command netstat -atln'
        ## Debug
        zshrc_load_status "Universal Admin aliases set."

    fi

    # --------------------------------
    #                                 \
    # ---------------------------------
    #          MOZCORE_DEBUG          |
    # ---------------------------------
    # Uncomment this for debugging purposes or verbose startup:
    zshrc_primary_load_status "Universal aliases set."
fi  ## END interactive

