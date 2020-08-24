# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#                        $ZDOT/zshrc.d/004_fink_env.zsh                      	  |
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
# File : ${ZDOT}/zshrc.d/004_fink_env.zsh
# sourced from  /etc/zshrc
# Version : 2.0.0
# Disable this file by renaming it to fink_env.disabled
# Change the absolute path if you have installed in a non-standard location.
# If fink is not installed in /sw, the alternative directory must be set here.
# Fink installation does this automatically.
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
# ----------------------------------------------------------------------------------
#                                FINK ENVIRONNEMENT                               	|
# ----------------------------------------------------------------------------------
 ##uncomment to debug
 # {{{ Loading status
     zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
 #}}}

 # {{{ Loading status
     zshrc_load_status () { echo "${YEL}  + Fink options load:${GREY} $*${NC}"}
 #}}}

if  [[ $IS_MAC ]] && [[ $HAS_FINK ]]; then
	if [[ $IS_MAC ]] && [[ -d /sw/fink ]]; then
	        export SWPREFIX='/sw'
	    else
	        export SWPREFIX='ALT_SWPREFIX'
        # --------------------------------
        #                                 \
        # ---------------------------------
        #         ZEAMONSHCORE_DEBUG       |
        # ---------------------------------
        ##
    fi

	if [[ $IS_MAC ]]  &&  [[ -f ${SWPREFIX}/bin/init.sh ]];then
	    source ${SWPREFIX}/bin/init.sh
        # --------------------------------
        #                                 \
        # ---------------------------------
        #         ZEAMONSHCORE_DEBUG       |
        # ---------------------------------
        ##
        # uncomment for debugging
        zshrc_primary_load_status "Fink environnement for zsh are now set."
	fi
fi
