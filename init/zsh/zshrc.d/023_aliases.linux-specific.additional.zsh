# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#                     023_aliases.linux-specific.additional.zsh                   |
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
# File :  ${ZDOT}/zshrc.d/023_aliases.linux-specific.additional.zsh
# sourced from  /etc/zshrc
# Version : 2.0.0
# Specific Linux aliases start here. You will probably want to edit this
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------
# 2020-03-08 :
#  . Making osx equivalent
#  . Package manager filter
#  . Desktop environment filter

#---------------------------------------------------------------------------------
#                                     CHANGES
#---------------------------------------------------------------------------------
# 2020-03-08 :
#  . Adding some order by categories

#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------

###############################################################################
###############################################################################
#------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                              LINUX SPEC ALIAS                                   |
# --------------------------------------------------------------------------------

if [[ -o interactive ]] && [[ $IS_LINUX ]]; then
      ##uncomment to debug
      # {{{ Loading status
          zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
      #}}}

      # {{{ Loading status
          zshrc_load_status () { echo "${YEL}  + Linux aliases load:${GREY} $*${NC}"}
      #}}}

        # --------------------------------
        #                                 \
        # ---------------------------------
        #        COMMON LINUX ALIAS       |
        # ---------------------------------
        [[ $IS_CINNAMON ]] && alias screensaver="cinnamon-screensaver-command --activate 2>/dev/null"
        [[ $IS_CINNAMON ]] && alias qq='cinnamon-session-quit --logout'
        [[ $IS_CINNAMON ]] && alias rr='cinnamon-session-quit --reboot'
        [[ $IS_CINNAMON ]] && alias ss='cinnamon-session-quit --power-off'
        [[ $IS_CINNAMON ]] && alias oa='Z_Open'

        # --------------------------------
        #                                 \
        # ---------------------------------
        #        SECURITY ALIAS           |
        # ---------------------------------
        # --------------------------------
        #                                 \
        # ---------------------------------
        #        ADMINISTRATION ALIAS     |
        # ---------------------------------

        # --------------------------------
        #                                 \
        # ---------------------------------
        #        NET/SERVEUR ALIAS        |
        # ---------------------------------
        # --------------------------------
        #                                 \
        # ---------------------------------
        #        DEVELOPPEMENT ALIAS      |
        # ---------------------------------

        ### Linux terminal conf
        if [[ $(which xwit | head -n 1 | awk '{ print $2,$3 }') != "not found" ]];then
            alias popx='command xwit -pop -id'
            alias iconx='command xwit -iconify -id'
        fi
        # xterm
        alias xterm='TERM_PROGRAM="xterm" COLORTERM="" xterm'
        # Konsole
        alias konsole='TERM_PROGRAM="konsole" COLORTERM="" konsole'
        # Gnome-Terminal
        alias gnome-terminal='TERM_PROGRAM="gnome-terminal" gnome-terminal'
        # xfce4 Terminal
        alias terminal='TERM_PROGRAM="Terminal" COLORTERM="Terminal" terminal'

        ### Set default interfaces for sys admin related commands
        # vnstat is console-based network traffic monitor. dnstop is console tool to analyze DNS traffic.
        # tcptrack and iftop commands displays information about TCP/UDP connections it sees on a
        # network interface and display bandwidth usage on an interface by host respectively.
        ## All of our servers eth1 is connected to the Internets via vlan / router etc ##
        alias dnstop='command dnstop -l 5 eth1'
        alias vnstat='command vnstat -i eth1'
        alias iftop='command iftop -i eth1'

        # work on wlan0 by default #
        # Only useful for laptop as all servers are without wireless interface
        alias iwconfig='command iwconfig wlan0'

        alias ethtool='command ethtool eth1'

        alias ubattery='clr ; command upower --dump'
        ##
        alias df='command df -kTh'
        # Make mount command output pretty and human readable format
        alias mount='command mount | command column -t'

        ## Get system memory, cpu usage, and gpu memory info quickly
        ## pass options to free ##
        alias meminfo='command free -m -l -t'
        ## Get server cpu info ##
        alias cpuinfo='command lscpu'
        # Assumes LPDEST is defined (default printer) #alias print='/usr/bin/lp -o nobanner -d $LPDEST'
        alias pjet='command enscript -h -G -fCourier9 -d $LPDEST' # Pretty-print using enscript
        alias libpath='builtin echo -e ${LD_LIBRARY_PATH//:/\\n}'
        #alias update='sudo apt-get update'
        #alias updatey='sudo apt-get -y update'
        ## older system use /proc/cpuinfo ##
        ##alias cpuinfo='less /proc/cpuinfo' ##
        ## get GPU ram on desktop / laptop##
        alias gpumeminfo='command grep -i --color memory /var/log/Xorg.0.log'
        alias rtra="command rm -Rf /home/$USER/.Trash/* 2>/dev/null ; command rm -Rf /home/$USER/.Trash/.* 2>/dev/null"
        alias x="exit"
        alias xx=" command rm $HOME/.zsh/zsh_history $HOME/.zsh_history &>/dev/null && return 1"
        alias xxx="command rm $HOME/.zsh/zsh_history $HOME/.zsh_history &>/dev/null  ;  kill $(command ps -u $USER | grep 'terminal' | awk '{ print $1 }')"
        # uncomment this for debugging purposes or verbose startup:
        # --------------------------------
        #                                 \
        # ---------------------------------
        #        SUDO ALIAS               |
        # ---------------------------------
        ##### Admistrator Alias
        if [[ $IS_ROOT ]] || [[ $IS_ADMIN ]]; then
            # View HTTP traffic
                alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"

        fi
 
# --------------------------------
#                                 \
# ---------------------------------
#          MOZCORE_DEBUG          |
# ---------------------------------
# uncomment for debugging
zshrc_primary_load_status  "Linux aliases exit set."
fi  ## END interactive
