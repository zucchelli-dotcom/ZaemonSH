# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#              $ZDOT/zshrc.d/200_environment.local.legacy.zsh                     |
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
# File:  $ZDOT/zshrc.d/200_environment.local.legacy.zsh
# sourced from /etc/zshrc
# Version: 2.0.0
# Add system-specific environment and path variables to this file.
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                     CHANGES
#---------------------------------------------------------------------------------
#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------

###################################################################################
###################################################################################
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                           DEFINE $ZDOT_USER                                     |
# --------------------------------------------------------------------------------
 if [[ -o interactive ]]; then
     ##uncomment to debug
     # {{{ Loading status
         zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
     #}}}

     # {{{ Loading status
         zshrc_load_status () { echo "${YEL}  + Environment systemaintenance load:${GREY} $*${NC}"}
     #}}}
    
     


     # Only attempt to source files from those directories that really exist.
     # If $ZDOT and $ZDOT_USER are the same directory, we want to avoid doing
     # this twice.
     if [[ -d $ZDOT_USER/my-functions ]];then
		 FPATH=$ZDOT_USER/my-functions:${FPATH}
		 export FPATH
     fi

     if [[ -d $ZDOT_USER && $ZDOT_USER != $ZDOT ]];then
         foreach myconfigfile in $ZDOT_USER/*
             source $myconfigfile
         end
     fi
    # --------------------------------
    #                                 \
    # ---------------------------------
    #         ZEAMONSH-DEBUG           |
    # ---------------------------------
    ##
    # uncomment for debugging
zshrc_primary_load_status "Environnement legacy local set."
fi
