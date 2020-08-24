# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#              $ZDOT/zshrc.d/131_environment.variables.additional.zsh             |
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

#---------------------------------------------------------------------------------
#                                  DESCRIPTION
#---------------------------------------------------------------------------------
# File:  $ZDOT/zshrc.d/131_environment.variables.additional.zsh
# sourced from /etc/zshrc
# Version: 2.0.0
# Add system-specific environment and path variables to this file.

#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------
# 23/12/2019 :
# • Add virtual system dectections to system variables
# 16/02/2020 :
# • Ordering a byte!!!

#---------------------------------------------------------------------------------
#                                     CHANGES
#---------------------------------------------------------------------------------
# 11/05/2007 :
# • William Scott create this one.
# 15/11/2017 :
# • Add declaration of ZaemonSH associative array to work with different kind of category.
# 18/07/2019 :
# • Add tests to later isolate exports or setopt statement .
# 18/07/2019 :
# • Add DESKTOP portable variable.
# 28/07/2019
# • # add osx zsh test native function for fink and macports
# 31/07/2019 :
# • Add a tempoorally test on $EDITOR variable, if the vim binary not found
#   $EDITOR=nano. Better to fix that later with install
# • On linux direct test like if [[ -x `which fink` ]] give an ouput replace by
#                             if [[ -x `which fink 2>/dev/null` ]]
# 31/07/2019 :
# • Add User test IS_ROOT/ADMIN/STAFF
# 18/08/2019 :
# • Add LINE and LINEP WB WG WN NOTEDIR
# 23/08/2019 :
# • Move this one between 013_environment.variables.additional.zsh to 002_environment.variables.additional.zsh
# • Clean script
# • Add debug message
# 31/08/2019 :
# • Replace which by whence in Binaries test statement
# 31/12/2019 :
# • Add conditionnal linking between homebrew and openssl with ruby.
# 16/02/2020 :
# • Add ranger condition and Environmental variables.
# 20/02/2020 :
# • Add FINDER_RUN=1

#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------
#uncomment to debug
# {{{ Loading status
  zshrc_primary_load_status() { echo "${GREEN} [ OK ]${NC}\033[1;32m $* \e[0m" }
#}}}

# {{{ Loading status
  zshrc_load_status () { echo "${YEL}    ++ Environment options load:${GREY} $*${NC}"}
#}}}
echo "${BRED}"

###################################################################################
###################################################################################
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                FIRST STUFF FOR ALL SESSIONS (EVEN NON-INTERACTIVE)          	  |
# --------------------------------------------------------------------------------
#  For CVS:
export CVS_RSH=ssh

# If you have a configuration file in /usr/local/bin
if [[ -f /usr/local/bin/init.sh ]];then
    source /usr/local/bin/init.sh
    zshrc_load_status
fi
# This is specific for crystallographers:
if [[ -f /usr/local/xtal/bin/init.sh ]];then
    source /usr/local/xtal/bin/init.sh
fi

# Use this construct to APPEND to current PATH:
# if [[ -d /example/path/bin ]]; then
#     PATH=$PATH:/example/path/bin
# fi

# If you have bin folder on ZDOT:
[[ -d $ZDOT/bin ]] && PATH=$PATH:$ZDOT/bin


# Use this construct to APPEND to current FPATH:
# if [[ -d /Path/To/another/location/functions ]]; then
#     FPATH=$FPATH:/Path/To/another/location/functions
# fi

# Avoid repeats in the path
export PATH FPATH
typeset -U path fpath

################################################################
# Sytem test statement
# These tests allow me to later isolate exports, or setopt statement based on the host machine's operating system
[[ "$OSTYPE" =~ ^(linux)+ ]] && export IS_LINUX=1
[[ "$OSTYPE" =~ ^(darwin)+ ]] && export IS_MAC=1
[[ "$OSTYPE" =~ ^(FreeBSD)+ ]] && export IS_FREEBSD=1
[[ "$OSTYPE" =~ ^(OpenBSD)+ ]] && export IS_OPENBSD=1
[[ "$OSTYPE" =~ ^(SunOS)+ ]] &&  export IS_SOLARIS=1 
if [[ $('uname') == *CYGWIN* ]]; then
   # We are using Cygwin in Windows
   export IS_CYGWIN=1
   # We are also in a virtualized Windows environment
   if [[ -f $(find /cygdrive/z -maxdepth 1 -type f -name ".zshrc.lnk") ]]; then
     export IS_VM=1
     export ALF_HOST="/cygdrive/z/.alf"
   fi
fi

################################################################
## Universal Binaries test statement
if [[ -x `whence vim 2>/dev/null` ]]; then export EDITOR="vim"; else export EDITOR="nano" ; fi


################################################################
# Users test statement (root or admin)
[[ "$UID" == "0" ]] &&  export IS_ROOT=1
[[ `groups | grep -w "admin"` ]] || [[ `groups | grep -w "wheel"` ]] && export IS_ADMIN=1
[[ "$IS_ROOT" != "1" ]] && [[ "$IS_ADMIN" != "1" ]] &&  export IS_USER=1


################################################################
# Network
local testnet=$(ifconfig -a inet 2>/dev/null | sed -n -e '/127.0.0.1/d' -e '/0.0.0.0/d' -e '/inet/p' | wc -l)
# [[ $IS_NETWORKUP ]] && [ "${testnet}" -gt 0  ] && IS_NETWORKUP=1
[ "${testnet}" -gt 0  ] && IS_NETWORKUP=1
unset testnet

[[ $SSH_CONNECTION ]] && IS_SSH=1

###############################################################################
###############################################################################
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                  NOW STUFF FOR ONLY THE INTERACTIVE SESSIONS            		  |
# # --------------------------------------------------------------------------------
# if [[ -o interactive ]] && [[ $ZDOT ]]; then
if [[ -o interactive ]] && [[ ! $IS_JAIL ]] && [[ $ZDOT ]]; then


    # Hook for desk activation
    # [[ -n  "$DESK_ENV" ]] && "$DESK_ENV" || true
    #
    # 

    export DESK_ENV="$HOME/.desk/desks"


    #######
    ##/!\##
    #######  27/03/2017
             ## Problem with GREP_OPTIONS with new version in mainly in linux

            # # Always enable colored `grep` output.
           # export GREP_OPTIONS='--color=auto'
           # (( ! ${+GREP_COLOR} )) && export GREP_COLOR='32;45'               #BSD
           (( ! ${+GREP_COLOR} )) && export GREP_COLOR='32;40'               #BSD
           if [[ $IS_LINUX ]]; then 
                (( ! ${+GREP_COLORS} )) && export GREP_COLORS="mt=${GREP_COLOR}"  #GNU
           fi
           if [[ ${OSTYPE} == openbsd* ]]; then
             if (( ${+commands[ggrep]} )); then
               alias grep='ggrep --color=auto'
             fi
           else
            alias grep='grep --color=auto'
           fi
    #######
    ##/!\##
    #######
    # PAGER and MANPAGER variables use "less -is" by default.  I've added in the -e
    # so that the pager quits when it reaches the end. This may annoy you.  If so,
    # just comment out (or change) what you see below.
    export PAGER="command less -ise"
    # export MANPAGER='command less -Xise'
    export MANPAGER='command less -ise'
    # Don’t clear the screen after quitting a manual page.
    # export MANPAGER='command less -X';

    # Highlight section titles in manual pages.
    # export LESS_TERMCAP_md="${yellow}";
    # less Colours
    if [[ ${PAGER} == 'less' ]]; then
     (( ! ${+LESS_TERMCAP_mb} )) && export LESS_TERMCAP_mb=$'\E[1;31m'   # Begins blinking.
     (( ! ${+LESS_TERMCAP_md} )) && export LESS_TERMCAP_md=$'\E[1;31m'   # Begins bold.
     (( ! ${+LESS_TERMCAP_me} )) && export LESS_TERMCAP_me=$'\E[0m'      # Ends mode.
     (( ! ${+LESS_TERMCAP_se} )) && export LESS_TERMCAP_se=$'\E[0m'      # Ends standout-mode.
     (( ! ${+LESS_TERMCAP_so} )) && export LESS_TERMCAP_so=$'\E[7m'      # Begins standout-mode.
     (( ! ${+LESS_TERMCAP_ue} )) && export LESS_TERMCAP_ue=$'\E[0m'      # Ends underline.
     (( ! ${+LESS_TERMCAP_us} )) && export LESS_TERMCAP_us=$'\E[1;32m'   # Begins underline.
    fi


    
    # # Prefer US English and use UTF-8.
    # export LANG='en_US.UTF-8';
    # export LC_ALL='en_US.UTF-8';

    # Prefer Frencheese and use UTF-8.
    export LANG='fr_FR.UTF-8';
    export LC_ALL='fr_FR.UTF-8';
    #####
    #/!\#
    #####
        # #### Problem with su admin user and history ####
        # Correct permissions on .zsh
        # Maybe good thing to verify if it not another instance of zsh.history
        #
        # .zsh_history in $HOME directory and not in $HOME/.zsh.
          #
        HISTSIZE='32768';
        # HISTSIZE=500
        HISTFILE=~/.zsh/zsh_history
        if (( ! EUID )); then
            HISTFILE=~/.zsh/zsh_history_root
            chown -R $UID:$GID ~/.zsh 2>/dev/null && chmod -R go-rwx ~/.zsh 2>/dev/null
        else
            HISTFILE=~/.zsh/zsh_history
            ##
            chown -R $UID:$GID ~/.zsh 2>/dev/null  && chmod -R go-rwx ~/.zsh 2>/dev/null
        fi
        SAVEHIST='32768';
        # SAVEHIST=500
        export HISTFILE HISTSIZE SAVEHIST

          #HISTFILE=~/.zsh/zsh_history
    # Omit duplicates and commands that begin with a space from history.
    export HISTCONTROL='ignoreboth';

    #####
    #/!\#
    #####
    # Enable persistent REPL history for `node`.
    NODE_REPL_HISTORY_FILE=~/.node_history;
    # Allow 32³ entries; the default is 1000.
    NODE_REPL_HISTORY_SIZE='32768';
    
    
    ## Ranger specific config
    [[ -x `whence ranger 2>/dev/null` ]] && export HAS_RANGER=1 
    ## RANGER_LOAD_DEFAULT_RC If this variable is set to FALSE, 
    ## ranger will not load the default rc.conf.  
    ## This can save time if you copied the whole rc.conf to ~/.config/ranger/ 
    ## and don't need the default one at all.
    [[ $HAS_RANGER ]] && [[ -d $HOME/.config/ranger ]] && export RANGER_LOAD_DEFAULT_RC="FALSE"

    [[ -x `whence vim 2>/dev/null` ]] && export HAS_VIM=1 
    [[ -x `whence emacs 2>/dev/null` ]] && export HAS_EMACS=1 
    [[ -x `whence tmux 2>/dev/null` ]] && export HAS_TMUX=1 

    ## Desktop
    if [[ -d $HOME/Bureau ]]; then
        export DESKTOP="$HOME/Bureau"
    else
        export DESKTOP="$HOME/Desktop"
    fi

    ##########################################
    #####  COLORS AND WARNINGS DEFINITION
    ##########################################
    export GREEN=$'\e[0;32m'
    export GREENB=$'\033[1;32m'
    export YELB=$'\033[1;33m'
    export YEL=$'\e[0;33m'
    export RED=$'\e[0;31m'
    export BRED=$'\033[1;31m'
    export BLUE=$'\e[0;34m'
    export BBLUE=$'\033[1;34m'
    export CYAN=$'\e[0;36m'
    export BCYAN=$'\033[1;36m'
    export MAGENTA=$'\e[0;35m'
    export BMAGENTA=$'\033[1;35m'
    export NC=$'\033[0m'              # No Color
    export WHITE=$'\e[0;40m'
    export WHITEB=$'\033[1;37m'

    ##########################################
    #	Formatting shortcut codes an COLOR
    #	Bold: \033[1m	Underline: \033[4m	Magenta: \033[35m	Yellow: \033[33m	Red: \033[31m
    # These must be defined with double quotes to be filtered correctly
    export BE="\033[31m*** "	#	Start formatting for "errors"
    export EE=" ***\033[0m"	#	End of format for errors.
    export BH="\033[35m\033[1m\033[4m"	#	Color code for key highlights
    export EH="\033[0m"	#	End of color code for key highlights
    export BK="\033[35m\033[1m"	#	Color code for key entry
    export EK="\033[0m"	#	End of formatting for key entry
    export BW="\033[33m"	#	formatting for "warnings"
    export EW="!\033[0m"	#	End of formatting for warnings.
    export BS="\033[1m"	#	Begin strong
    export ES="\033[0m"	#	End strong
    export WB="\033[31m [ WARNING ]"
    export WG="\033[32m [ OK ]"
    export WN="\033[36m [ NOTHING TO DO ]"

    ##########################################
    ## Lines
    export LINE="----------------------------------------------------------------------------------------------"
    export LINEM="--------------------------------"
    export LINEP="_______________________________________________________________________________________________"
    export LINEPM="________________________________"
    export LINEE="==============================================================================================="
    export LINEEM="================================"

    ##
    export DB="-----DEBUG"
    ###################################################
    ### ZAEMONSH ALIAS AND FUNCTIONS PATH VARIABLES ###
    ###################################################
    # if [[ $ZDOT ]]; then
        ##########################################
        ##  ALIAS PATH VARIABLES
        export P_MAINALIASFILE=$ZDOT/zshrc.d/020_aliases.main.zsh
        export P_UNIALIASFILE=$ZDOT/zshrc.d/021_aliases.universal.zsh
        export P_DARWALIASFILE=$ZDOT/zshrc.d/022_aliases.darwin-specific.additional.zsh
        export P_LINUXALIASFILE=$ZDOT/zshrc.d/023_aliases.linux-specific.additional.zsh
        export P_GRMLALIASFILE=$ZDOT/zshrc.d/local-functions/etc/grmlrc/grmlrc
        export P_PLUGINSALIASFILE=$ZDOT/plugins
        #export P_PERSALIASFILE=$ZDOT/zshrc_local.d/021_MYAliases.additional.zsh

        ##########################################
        ##  VARIABLES FUNCTIONS PATH 
        export P_ALLACTFCTPATH="$fpath"
        # OSX Zsh test native function folder
        local NATZSHNB=$(ls /usr/share/zsh | grep -v "site-functions")
        if [ IS_MAC ] && [[ $NATZSHNB == $ZSH_VERSION  ]]; then
            export P_NATFCTDIR="/usr/share/zsh/$ZSH_VERSION/functions"
            export IS_ZSH_NATIVE=1
        elif [[ "/usr/local/share/zsh/$ZSH_VERSION/functions" ]] && [[ "/usr/local/Cellar/zsh/$ZSH_VERSION/zsh/HEAD-95882ef/share/zsh/functions" ]]; then
            export P_NATFCTDIR="/usr/local/Cellar/zsh/HEAD-95882ef/share/zsh/functions"
            export  IS_ZSH_HOMEBREW_HEAD=1
        elif [[ "/usr/local/share/zsh/$ZSH_VERSION/functions" ]] && [[ "/usr/local/Cellar/zsh/$ZSH_VERSION/share/zsh/functions" ]]; then
            export P_NATFCTDIR="/usr/local/share/zsh/$ZSH_VERSION/functions"
            #export P_NATFCTDIR="/usr/local/Cellar/zsh/$ZSH_VERSION/share/zsh/functions"i
            export  IS_ZSH_HOMEBREW=1
        fi
        
        ####################################
        export P_ZDOTBINDIR="$ZDOT/bin"
        export P_ZDOTLOGDIR="$ZDOT/log"
        export P_ZDOTMANDIR="$ZDOT/man"
        export P_ZDOTPLUGINSDIR="$ZDOT/plugins"
        # # export P_PLUGFCTDIR="$ZDOT/plugins"
        export P_ZDOTZSHENVDIR="$ZDOT/zshenv.d"
        export P_ZDOTCONFDIR="$ZDOT/zshrc.d"
        

        export P_SYSFCTDIR="$ZDOT/zshrc.d/local-functions"
        export P_SYSETCDIR="$ZDOT/zshrc.d/local-functions/etc"
        export P_GRMLRCFIL="$ZDOT/zshrc.d/local-functions/etc/grmlrc/grmlrc"
        export P_DISTFCTFIL="$ZDOT/zshrc.d/030_functions.distributed.zsh"
        export P_ADDIFCTFIL="$ZDOT/zshrc.d/032_functions.additional.zsh"
        export P_CORFCTFIL="$ZDOT/zshrc.d/033_functions.core.zsh"
        export P_DARWFCTFIL="$ZDOT/zshrc.d/034_functions.darwin-specific.zsh"
        export P_UNIFCTFIL="$ZDOT/zshrc.d/035_functions.universal.zsh"
        export P_LINUFCTFIL="$ZDOT/zshrc.d/036_functions.linux-specific.zsh"
        export P_PERSFCTDIR="$ZDOT/zshrc_local.d/site-functions"


        ###################################################
        ## ZAEMONSH CONFIG FILE BY SYSTEM ASSOCiATIVE ARRAY
        declare -A configfilebysystem
        configfilebysystem=(core $P_CORFCTFIL darwin $P_DARWFCTFIL universal $P_UNIFCTFIL linux $P_LINUFCTFIL)
        ##
        declare -A sysfctlistbycategory
        sysfctlistbycategory=(___\[SUDONEED\]___ FCTLIST_SU_ ___\[ADMINISTRATION\]___ FCTLIST_ADM_ ___\[DAILYUSE\]___ FCTLIST_DAI_ ___\[DEVELOPMENT\]___ FCTLIST_DEV_ ___\[MEDIA\]___ FCTLIST_MED_ ___\[NETWORK\]___ FCTLIST_NET_)

        declare -A systemsuffixlist
        systemsuffixlist=(darwin DARW universal UNI linux LINU)

        ##
        declare -A corfctlistbycategory
        corfctlistbycategory=(___\[LINUX\]___ FCTLIST_ZCOR_LINU ___\[OSX\]___ FCTLIST_ZCOR_DARW ___\[UNIVERSAL\]___ FCTLIST_ZCOR_UNI)
        #######
        ##/!\##
        #######
            #FUNCTIONDIR=$(find $ZDOT/zshrc_local.d/site-functions -type d | grep -v README | grep -v .DS_Store | tail +2)
            #FUNCTIONLIST=$(find $ZDOT/zshrc_local.d/site-functions -type f | grep -v README | grep -v .DS_Store | sed 's/.*\///')
        #######
        ##/!\##
        #######

    # fi

    ###############################################################################
    ###############################################################################
    # ------------------------------------------------------------------------------
    #                                                                               \
    # --------------------------------------------------------------------------------
    #                  LOCAL DARWIN-SPECIFIC ENVIRONMENT CONFIGURATION                |
    # --------------------------------------------------------------------------------
    if [[ "$OSTYPE" =~ ^(darwin)+ ]]; then

        ## Set Default VISAUALEDITOR
        export VISUALEDITOR="Sublime Text"

       
        ## Fink specific (old for compatibility)
        if [[ -d $SWPREFIX/fink ]]; then
            export localfink=$SWPREFIX/fink/dists/local/main/finkinfo
            export unstablefink=$SWPREFIX/fink/dists/unstable/main/finkinfo
            export stablefink=$SWPREFIX/fink/dists/stable/main/finkinfo
            export oldfink=$SWPREFIX/fink/10.2-gcc3.3/unstable/main/finkinfo
         fi
         #export public_html='~/public_html'

        ## Users test statement (root or admin)
        local LOGINAME=$(id -p | grep login | awk '{ print $2 }')
        if [[ $IS_MAC ]] && [[ $LOGINAME ]]; then
                export IS_SU=1;
                unset IS_USER
        fi

        ## FINDER TEST
        [[ $(ps -awx | grep -v "grep" | grep -w Finder.app) ]] && export FINDER_RUN=1
        # ZeamonSH LaunchAgents test
        [[ -f ~/Library/LaunchAgents/zsh.refresh.completion.plist ]] && export HAD_LAUNCH_REFRESH=1

        [[ $(/usr/sbin/system_profiler SPHardwareDataType 2>/dev/null | grep "Model Identifier" | grep "Book") ]] && export IS_LAPTOP=1 
        
        ## Darwin binaries test statement
        [[ -x `whence mdfind 2>/dev/null` ]] && export HAS_MDFIND=1
        [[ -x `whence fink 2>/dev/null` ]] && export HAS_FINK=1
        [[ -x `whence port 2>/dev/null` ]] && export HAS_PORT=1 
        [[ -x `whence brew 2>/dev/null` ]] && export HAS_BREW=1 
        
        
        ## First verify that login user have this uid set correctly
        ## And the correct zsh configuration (.zshrc file | .zsh folder) are used.
        if [[ $IS_SU ]] || [[ $IS_ROOT ]];then
          HISTFILE=~/.zsh/zsh_history_root
        else
          HISTFILE=~/.zsh/zsh_history
        fi
        SAVEHIST=500
        export HISTFILE HISTSIZE SAVEHIST

        if [[  ( $TERM_PROGRAM == iTerm.app )  ]];then
            #### iTerm.app on OS X possible options
            export TERM="xterm-256color"
            export DISPLAY="0:0"
            export CLICOLOR=1
            ## For white background
            # (( ! ${+LSCOLORS} )) && export LSCOLORS=ExFxCxDxBxegedabagacad
            ## For Dark background
            (( ! ${+LSCOLORS} )) && export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
            ##
                 # (( ! ${+LSCOLORS} )) && export LSCOLORS='ExfxcxdxbxGxDxabagacad'
            # export LS_COLORS='di=1;34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43'
            ## For you !
            # export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
        elif [[  $TERM_PROGRAM == (Apple_Terminal)  ]]; then
            #### Terminal.app on OS X possible options
            # Needs to be configured within the Terminal.app Preferences
        elif [[  $TERM == xterm  ]]; then
                #xterm -bg black -fg white -cr grey -ls -geometry 80X25 -colorBD yellow -troughColor grey -font 9x15 -sr -scrollColor RoyalBlue3
                #alias rxvt="xterm -bg black -fg white -cr grey -ls -geometry 80X25 -colorBD yellow -troughColor grey -font 9x15 -sr -scrollColor RoyalBlue3 &"
                alias rxvt="xterm -bg black -fg white -cr grey  -geometry 126X57 &"
        elif [[  $TERM_PROGRAM == rxvt ]]  && [[ "$OSTYPE" =~ ^(darwin)+ ]] || [[ $COLORTERM == *rxvt* ]]; then
            #### rxvt

        elif [[ $COLORTERM == (Terminal|gnome-terminal|xfce4-terminal) ]];then
            #### xfce4 Terminal

        elif [[ -n $KONSOLE_DBUS_SERVICE || $TERM_PROGRAM == konsole ]]; then

        elif [[  $TERM_PROGRAM == xterm ]] && [[ "$OSTYPE" =~ ^(darwin)+ ]] || [[ $TERM == xterm ]]; then
            #### xterm

        else
            # Other options?
            true
        fi

        ###
        #  Crystallography stuff moved to the file environment.xtal.d
        #  Everything is off by default.  To activate a file, do this:
        #  mv foo.zsh.disabled  foo.zsh
        if [[ -d "${ZDOT}/zshenv.d/environment.xtal.d" ]]; then
            foreach file in $(command ls ${ZDOT}/zshrc.d/environment.xtal.d/* | grep -v disabled | grep -v README | grep -v 00master )
                source $file
                # print "sourcing $file"  # un-comment for debug
            end
        fi
        # ruby-build installs a non-Homebrew OpenSSL for each Ruby version installed and these are never upgraded.
        # To link Rubies to Homebrew's OpenSSL 1.1 (which is upgraded) add the following
        # to your ~/.zshrc:
        # export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"]

        #############################################################################
        #
        #  Local Java
        # Gary Kerbaugh's Java stuff
        # {====>}
        # JAVA_CMD=/usr/bin/java
        #
        # JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home
        # export JAVA_HOME
        # CLASSPATH variables:
        #
        #############################################################################

        # CLASSPATH=$CLASSPATH:/System/Library/Frameworks/JavaVM.framework/Home:/System/Library/Frameworks/JavaVM.framework/Classes/classes.jar:/System/Library/Frameworks/JavaVM.framework/Classes/ui.jar:.
        #
        # export  CLASSPATH

        # JBOSS_CLASSPATH=/Developer/jboss/bin
        # JIKESPATH=.:/System/Library/Frameworks/JavaVM.framework/Classes/classes.jar:/System/Library/Frameworks/JavaVM.framework/Classes/ui.jar:/Developer/jakarta-tomcat-4.0.3/common/lib/servlet.jar:/Developer/jakarta-tomcat-4.0.3/common/lib/xerces.jar:/Library/Java/Extensions/activation.jar:/Library/Java/Extensions/jdbc2_0-stdext.jar:/Library/Java/Extensions/pgjdbc2.jar:/System/Library/Frameworks/JavaVM.framework/Home/lib/dt.jar:/System/Library/Frameworks/JavaVM.framework/Home/lib/ext/jnet.jar:/System/Library/Frameworks/JavaVM.framework/Versions/1.3.1/Home/lib/ext/jpda.jar:/System/Library/Frameworks/JavaVM.framework/Versions/1.3.1/Home/lib/ext/jsse.jar

        # export JIKESPATH
        # *************************************************************************
    fi # [[ $IS_MAC ]]

    ###############################################################################

    ###############################################################################
    # ------------------------------------------------------------------------------
    #                                                                               \
    # --------------------------------------------------------------------------------
    #                  LOCAL LINUX-SPECIFIC ENVIRONMENT CONFIGURATION                |
    # --------------------------------------------------------------------------------

    ############################################
    ### linux bibaries test
    if [[ $IS_LINUX ]]; then
        if [[ -x `whence apt-get 2>/dev/null` ]]; then export has_apt=1; fi
        if [[ -x `whence yum 2>/dev/null` ]]; then export has_yum=1; fi
        if [[ -x `whence dnf 2>/dev/null` ]]; then export has_dnf=1; fi

        # Linux users test
        if  [[ $IS_ADMIN == 1 ]] && [[ ! `groups | grep -w "wheel"` ]] ; then
                export IS_SU=1
                unset IS_ADMIN
                export IS_USER=1
        fi

        if [[ $IS_ADMIN == 1 ]] && [[ $IS_USER == 1 ]] ; then
                export IS_SU=1
                unset IS_USER
                export IS_ADMIN=1
        fi

        if [[ $XDG_CURRENT_DESKTOP =~ (Cinnamon)+ ]]; then
            export IS_CINNAMON=1
        fi
    fi
        # --------------------------------
        #                                 \
        # ---------------------------------
        #         ZEAMONSH-DEBUG           |
        # ---------------------------------
        ##
        # uncomment for debugging
          zshrc_primary_load_status "Additionnal environment variables set."
fi  #  [[ -o interactive ]]
