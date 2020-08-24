# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |   
#                                - ZAEMONSH -                                     |
#              $ZDOT/zshrc.d/205_environment.login.message.zsh                    |
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
# File:  $ZDOT/zshrc.d/205_environment.login.message.zsh
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
#                           LOGIN MESSAGE ENVIRONMENT                            |   
# --------------------------------------------------------------------------------    
if [[ -o interactive ]]; then
    #  This works for both Terminal.app and iTerm.app as well as X-term
    #  set the title and tab values to current directory
    #  Stuff that appears when the interactive shell starts up:
    ## echo ""
    ## echo -e "------------------------------------------------------------------------------------------------"
    # Give time since last reboot.  Blank print statement gives us a new line
    uptime=$(uptime 2>/dev/null ) 
    print "\e[36mTime: $uptime \e[0m"
    wait
    # Tell us what computer we are on and what directory we are in
    print "\e[36m$HOST\e[0m\:\:\e[36m$PWD\e[0m" 
    wait
    # What version of zsh are we running?
    print "\e[36mInitializing zsh version number $ZSH_VERSION \e[0m"
    wait
fi  #  [[ -o interactive ]]  
