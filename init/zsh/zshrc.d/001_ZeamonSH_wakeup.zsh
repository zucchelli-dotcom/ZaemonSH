# -----------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#                     $ZDOT/zshrc.d/001_ZeamonSH_wakeup.zsh                       |
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
# File : ${ZDOT}/zshrc.d/001_ZeamonSH_wakeup.zsh
# sourced from  /etc/zshrc
# Version : 2.0.0
# Add system-specific environment and path variables to this file.

#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                     CHANGES
#---------------------------------------------------------------------------------
# 11/05/2016 :
# • Create this one.

# 04/10/2017 :
# • Add linux compatibility.

#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------

###################################################################################
###################################################################################
# ---------------------------------------------------------------------------------
#                                                                                  \
# -----------------------------------------------------------------------------------
#                                  ZAEMONSH WAKEUP                                   |
# -----------------------------------------------------------------------------------
if [[ -o interactive ]]; then
     #uncomment to debug
 # {{{ Loading status
   #########zshrc_primary_load_status() { echo "\e[32m***************************$(date "+%H:%M:%S")******************************\e[0m" }
 #}}}

 # {{{ Loading status
   #########zshrc_load_status () { ''}
 #}}}
if [[ "$OSTYPE" =~ ^(darwin)+ ]]; then
        #########zshrc_primary_load_status
        print "\e[35m--You run ZAEMONSH-1_v$ZAEMONSHVERSION on $OSTYPE system--\e[0m" && wait;

    fi
    if [[ "$OSTYPE" =~ ^(linux)+ ]]; then
        #########zshrc_primary_load_status
        print "\e[35m--You run ZAEMONSH-1_v$ZAEMONSHVERSION on $OSTYPE system--\e[0m" && wait;

    fi
fi  #  [[ -o interactive ]]
