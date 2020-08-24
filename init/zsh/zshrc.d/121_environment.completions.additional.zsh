# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#              $ZDOT/zshrc.d/121_environment.completions.additional.zsh           |
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
# File:  $ZDOT/zshrc.d/121_environment.completions.additional.zsh
# sourced from /etc/zshrc
# Version: 2.0.0
# Set-up for custom-made Darwin-Specific completions for
# Apple's "open" command, and customized users & hosts.
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                     CHANGES
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
            zshrc_load_status () { echo "${YEL}  + Environment additional completion load:${GREY} $*${NC}"}
        #}}}
    if [[ $IS_MAC ]]; then
        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                  MAKE THE "OPEN -A" COMPLETION WORK FASTER                      |
        # --------------------------------------------------------------------------------
        # This is to make the "open -a" command completion snappier.
        # touching the file upon shell startup will trigger various launchd items
        # that in turn will ensure completions are up to date.  We run the command once
        # now to establish a short-term SpotLight cache.
        if [[ -f ~/Library/LaunchAgents/zsh.refresh.completion.plist  || -f /Library/LaunchAgents/zsh.refresh.completion.plist  ]];then
                        touch ~/.zsh/zrefresh 2>/dev/null
                        # chmod 777 ~/.zsh/zrefresh  2>/dev/null
                        chmod u-x  ~/.zsh/zrefresh
                        chmod go-rwx ~/.zsh/zrefresh
        fi
        # This seems to work better:
        if [[ $HAS_MDFIND ]] && [[ -x /usr/bin/mdfind ]];then
            ( mdfind -onlyin /Applications -onlyin /Developer "kMDItemContentType == 'com.apple.application-*'" >| /dev/null 2>&1 & ; );
        fi

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #     DARWIN $HOSTS VARIABLE FOR HOST COMPLETION WITHH SSH AND RELATED PROGRAMS   |
        # --------------------------------------------------------------------------------
        ## host and user names completions settings
        # Checks if Z_Host_user_completion_settings is in ~/.zsh/cache/
        # If not, create one with default settings.
        if [[ ! -f ~/.zsh/cache/Z_Host_user_completion_settings ]]; then
            command mkdir -p ~/.zsh/cache/
            command cp $ZDOT/zshrc.d/local-functions/core/Z_Host_user_completion_settings ~/.zsh/cache/.
        fi
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # Source Z_Host_user_completion_settings
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        source ~/.zsh/cache/Z_Host_user_completion_settings
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # Create custom_hosts and custom_users in ~/.zsh/cache/
        # Issue a warning message if they are empty and if
        # USE_CUSTOM_USERS and USE_CUSTOM_HOSTS variables are
        # set to 'yes'.
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        command touch ~/.zsh/cache/custom_hosts
        command touch ~/.zsh/cache/custom_users

        if [[ -z $( < ~/.zsh/cache/custom_hosts ) && $USE_CUSTOM_HOSTS == 'yes' ]]; then
            if [[ $ENCODING == '1:14' ]]; then
                print ""
                print "\e[1m  custom_hostsファイルが空です. Z_Host_setupコマンドを実行してください.\e[0m"
                print ""
            else
                print ""
                print "\e[1m  custom_hosts file is empty.  Please execute Z_Host_setup.\e[0m"
                print ""
            fi

        fi

        if [[ -z $( < ~/.zsh/cache/custom_users ) && $USE_CUSTOM_USERS == 'yes' ]]; then
            if [[ $ENCODING == '1:14' ]]; then
                print ""
                print "\e[1m  custom_usersファイルが空です. Z_user_setupコマンドを実行してください.\e[0m"
                print ""
            else
                print ""
                print "\e[1m  custom_users file is empty.  Please execute Z_user_setup.\e[0m"
                print ""
            fi

        fi
        #~~~~~~~~~~~~~~~~~~~~~~
        # host completion setup
        #~~~~~~~~~~~~~~~~~~~~~~
        #------------------------------------------------
        # Define a list of hosts for host name completion
        #------------------------------------------------
        if [[ $USE_SSH_KNOWN_HOSTS == 'yes' && -f ~/.ssh/known_hosts ]]; then
            ssh_hosts=(
            #----------------------------------------------
            # This gets known hosts from ~/.ssh/known_hosts
            #----------------------------------------------
        #   $( < ~/.ssh/known_hosts | command cut -f 1 -d " " | command cut -f 1 -d , )
            $( < ~/.ssh/known_hosts | command cut -f 1 -d " " | command cut -f 1 -d , | command cut -f 1  -d ":" | sed -e 's/\[//g' -e 's/]//g' )
            )
            HOSTS+=( $ssh_hosts )
        fi


        if [[ $USE_CUSTOM_HOSTS == 'yes' && -f ~/.zsh/cache/custom_hosts ]]; then
            custom_hosts=(
            #----------------------------------
            # This gets hosts from custom_hosts
            #----------------------------------
            $( < ~/.zsh/cache/custom_hosts )
            )
            HOSTS+=( $custom_hosts )
        fi


        if [[ $USE_ETC_HOSTS == 'yes' ]]; then
            etc_hosts=(
            #--------------------------------
            # This gets hosts from /etc/hosts
            #--------------------------------
            ${$( < /etc/hosts | command cut -d : -f 1,7 | command grep -v "#" )//:*/}
            )
            HOSTS+=( $etc_hosts )
        fi
        #-----------------------
        # get rid of the repeats
        #-----------------------
        typeset -U HOSTS
        zstyle -e ':completion:*' hosts 'reply=($HOSTS)'
        #~~~~~~~~~~~~~~~~~~~~~~
        # user completion setup
        #~~~~~~~~~~~~~~~~~~~~~~
        #------------------------------------------------
        # Define a list of users for user name completion
        #------------------------------------------------
        if [[ $USE_ETC_USERS == 'yes' ]]; then
            zmodload -i zsh/parameter
            etc_users=( $userdirs[(I)*] )
            USERS+=( $etc_users )
        fi

        if [[ $USE_CUSTOM_USERS == 'yes' && -f ~/.zsh/cache/custom_users ]]; then
            custom_users=(
            $( < ~/.zsh/cache/custom_users )
            )
            USERS+=( $custom_users )
        fi

        #-----------------------
        # get rid of the repeats
        #-----------------------
        typeset -U USERS
        zstyle -e ':completion:*' users 'reply=($USERS)'
    fi
    #################################################################
    # ###END of if [[ "$OSTYPE" =~ ^(darwin)+ ]]


    if [[ -o interactive && $IS_LINUX ]]; then

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #    LINUX $HOSTS VARIABLE FOR HOST COMPLETION WITHH SSH AND RELATED PROGRAMS     |
        # --------------------------------------------------------------------------------
        #=========================================
        # host and user names completions settings
        #=========================================
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # Checks if Z_Host_user_completion_settings is in ~/.zsh/cache/
        # If not, create one with default settings.
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        if [[ ! -f ~/.zsh/cache/Z_Host_user_completion_settings ]]; then
            command mkdir -p ~/.zsh/cache/
            command cp $ZDOT/zshrc.d/local-functions/core/Z_Host_user_completion_settings $HOME/.zsh/cache/
        fi
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # Source Z_Host_user_completion_settings
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        source ~/.zsh/cache/Z_Host_user_completion_settings
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        # Create custom_hosts and custom_users in ~/.zsh/cache/
        # Issue a warning message if they are empty and if
        # USE_CUSTOM_USERS and USE_CUSTOM_HOSTS variables are
        # set to 'yes'.
        #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        command touch ~/.zsh/cache/custom_hosts
        command touch ~/.zsh/cache/custom_users

        if [[ -z $( < ~/.zsh/cache/custom_hosts ) && $USE_CUSTOM_HOSTS == 'yes' ]]; then
            if [[ $ENCODING == '1:14' ]]; then
                print ""
                print "\e[1m  custom_hostsファイルが空です. Z_Host_setupコマンドを実行してください.\e[0m"
                print ""
            else
                print ""
                print "\e[1m  custom_hosts file is empty.  Please execute Z_Host_setup.\e[0m"
                print ""
            fi
        fi

        if [[ -z $( < ~/.zsh/cache/custom_users ) && $USE_CUSTOM_USERS == 'yes' ]]; then
            if [[ $ENCODING == '1:14' ]]; then
                print ""
                print "\e[1m  custom_usersファイルが空です. Z_user_setupコマンドを実行してください.\e[0m"
                print ""
            else
                print ""
                print "\e[1m  custom_users file is empty.  Please execute Z_user_setup.\e[0m"
                print ""
            fi
        fi
        #~~~~~~~~~~~~~~~~~~~~~~
        # host completion setup
        #~~~~~~~~~~~~~~~~~~~~~~
        #------------------------------------------------
        # Define a list of hosts for host name completion
        #------------------------------------------------
        if [[ $USE_SSH_KNOWN_HOSTS == 'yes' && -f ~/.ssh/known_hosts ]]; then
            ssh_hosts=(
            #----------------------------------------------
            # This gets known hosts from ~/.ssh/known_hosts
            #----------------------------------------------
        #   $( < ~/.ssh/known_hosts | command cut -f 1 -d " " | command cut -f 1 -d , )
            $( < ~/.ssh/known_hosts | command cut -f 1 -d " " | command cut -f 1 -d , | command cut -f 1  -d ":" | sed -e 's/\[//g' -e 's/]//g' )
            )
            HOSTS+=( $ssh_hosts )
        fi


        if [[ $USE_CUSTOM_HOSTS == 'yes' && -f ~/.zsh/cache/custom_hosts ]]; then
            custom_hosts=(
            #----------------------------------
            # This gets hosts from custom_hosts
            #----------------------------------
            $( < ~/.zsh/cache/custom_hosts )
            )
            HOSTS+=( $custom_hosts )
        fi

        if [[ $USE_ETC_HOSTS == 'yes' ]]; then
            etc_hosts=(
            #--------------------------------
            # This gets hosts from /etc/hosts
            #--------------------------------
            ${$( < /etc/hosts | command cut -d : -f 1,7 | command grep -v "#" )//:*/}
            )
            HOSTS+=( $etc_hosts )
        fi
            #-----------------------
            # get rid of the repeats
            #-----------------------
            typeset -U HOSTS
            zstyle -e ':completion:*' hosts 'reply=($HOSTS)'
        #~~~~~~~~~~~~~~~~~~~~~~
        # user completion setup
        #~~~~~~~~~~~~~~~~~~~~~~
        #------------------------------------------------
        # Define a list of users for user name completion
        #------------------------------------------------
        if [[ $USE_ETC_USERS == 'yes' ]]; then
            zmodload -i zsh/parameter
            etc_users=( $userdirs[(I)*] )
            USERS+=( $etc_users )
        fi

        if [[ $USE_CUSTOM_USERS == 'yes' && -f ~/.zsh/cache/custom_users ]]; then
            custom_users=(
            $( < ~/.zsh/cache/custom_users )
            )
            USERS+=( $custom_users )
        fi
        #-----------------------
        # get rid of the repeats
        #-----------------------

        typeset -U USERS
        zstyle -e ':completion:*' users 'reply=($USERS)'
    fi
    #################################################################
    # ###END of if [[ -o interactive && $(uname) == Linux ]]
# --------------------------------
#                                 \
# ---------------------------------
#         ZEAMONSH-DEBUG           |
# ---------------------------------
    ##
    # uncomment for debugging
    zshrc_primary_load_status "Environment additionnal completion set."
fi  #  [[ -o interactive ]]
