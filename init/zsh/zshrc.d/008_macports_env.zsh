# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |   
#                                - ZAEMONSH -                                     |
#                        $$ZDOT/zshrc.d/005_macports.zsh                      	  |
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
# File : ${ZDOT}/zshrc.d/005_macports.zsh
# sourced from  /etc/zshrc
# Version : 2.0.0
# Disable this file by renaming it to 005_macports.zsh.disabled
# Change the absolute path if you have installed in a non-standard location.
# If Macports is not installed in /opt the alternative directory must be set here.
# Macports installation does this automatically.
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
# ---------------------------------------------------------------------------------
#                                                                                  \
# -----------------------------------------------------------------------------------
#                              MACPORTS ENVIRONNEMENT                                |   
# -----------------------------------------------------------------------------------
##uncomment to debug
# {{{ Loading status
  zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
#}}}

# {{{ Loading status
  zshrc_load_status () { echo "${YEL}  + Macports options load:${GREY} $*${NC}"}
#}}}

if  [[ $IS_MAC ]] && [[ $HAS_PORT ]]; then
    if [[ ! -f $HOME/.zsh/macportnowarn ]]; then 
	        export OPTPREFIX='/opt/local'
	else
	        export OPTPREFIX='ALT_OPTPREFIX'
	fi
    # --------------------------------
    #                                 \ 
    # ---------------------------------
    #         ZEAMONSHCORE_DEBUG       |  
    # --------------------------------- 
    zshrc_primary_load_status "Macports environnement for zsh are now add."
fi
