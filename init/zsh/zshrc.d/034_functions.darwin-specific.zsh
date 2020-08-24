# -----------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#           $ZDOT/zshrc.d/034_functions.darwin-specific.additional.zsh            |
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
# File :  ${ZDOT}/zshrc.d/034_functions.darwin-specific.additional.zsh
# sourced from  /etc/zshrc
# Version : 2.0.0
# File local-functions
# Use this file to load the Darwin extra functions that come with ZEAMONSH templates.
# Create a file functions.mine to load your own home-grown functions.
# Type "Z_Help_template_functions [foo]" for a description of each function [foo]
# In this file we autload all or a subset of the function in the directory
# called $ZDOT/zshrc.d/local-functions/darwin (or $ZDOT_TEMPLATE/local-functions).
# The set I am confident you won't want to live without, so they are
# autoloaded by default.  This is defined with LOAD_DARWIN_FUNCTIONS='YES'
# These controlling variables can be changed to load the second and third
# set by changing 'NO' to 'YES' in each case.
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------
# 11/01/2018 :
# • Verify if apache function can be move to universal.

#---------------------------------------------------------------------------------
#                                     CHANGES
#--------------------------------------------------------------------------------#
# 28/09/2017
# - Reorder function :
# • Move "Z_UpdateOSX" function between (033)FCTLIST_DARWCORE to (034)FCTLIST_DARWSU
# • Move "open" "edit" function between (033)FCTLIST_DARWCORE to (034)FCTLIST_DARWDAI
# • Move "quit" "quit_app" between (033)FCTLIST_DARWCORE to (034)FCTLIST_DARWDAI
# • Move "Z_Sudo_open" "sudo_do" between (033)FCTLIST_DARWCORE to (034)FCTLIST_DARWSU
# 30/09/2017
# • Change configuration description.
# 11/11/2017 :
# • Change function list naming
# 25/11/2017
# • Add autoload function for each list of functions.
# 07/01/2018 :
# • Merge all past functions related to Finder to finder function.
# • Merge all past functions related to secutity command into keychain function.
# • Merge all past functions related to User command into user function.
# • Merge all past functions related to groups (addgroup delete_group) command into group function.
# • Merge all past functions related to alf (ALFFactorySettings ALFSettings) with firewall one.
# 11/01/2018 :
# • Add apache function.
# • Merge all past functions related to brew (brew-diff brewInstall ) with breww one.
# • Merge all past functions related to forklift (cdleft cdright) with  one.
# • Merge all past functions related to plist (cf. plist function) with one.
# 14/01/2018 :
#  • Merge all relative X11 functions (open-x11, 8bitx, newx, remotex, xtwit, startremote
#    startenlightenment, startwm ) with this X11 one .
# 30/07/2019
# • Add additionnals functions functions eject font-smoothing .
# 04/07/2019
# • Add additionnals functions : flush_osx_cache update_supervisor edit-keymapping mavericks-hacks lion-hacks make_app tarsh.
# 2020-02-21 :
# • Move service to FCTLIST_SU_DARWW
# 2020-02-29 :
#  • Add KextLondoncalling LaunchLondoncalling MacOSDoctor MacOSHarden functions in FCTLIST_SU_DARW
# 2020-06-28 :
#  • termFullScreen termMaximize termMultiTab termSplit termVSplit
# 2020-06-30 :
#  • Add fdc to FCTLIST_DAI_DARW.
# 2020-07-31 :
# • Merge termFullScreen termMaximize termSplit termVSplit to termwindow in FCTLIST_DAI_DARW.


#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------
if [[ -o interactive ]]; then
        ########################################################
        #                                                      #
        #        For Darwin functions, edit these:             #
        #                                                      #
                     LOAD_DARWIN_FUNCTIONS='YES'               #
        #                                                      #
        #                                                      #
        ########################################################

    if [[ $LOAD_DARWIN_FUNCTIONS == YES ]]  &&  [[ $IS_MAC ]]; then
         ##uncomment to debug
         # {{{ Loading status
             zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
         #}}}

         # {{{ Loading status
             zshrc_load_status () { echo "${YEL}  + Darwin functions load:${GREY} $*${NC}"}
         #}}}
        if [[ -d $ZDOT_TEMPLATE/zshrc.d/local-functions/darwin ]];then
            FPATH=$ZDOT_TEMPLATE/zshrc.d/local-functions/darwin:$FPATH
        fi

        if [[ -d $ZDOT/zshrc.d/local-functions/darwin ]];then
            FPATH=$ZDOT/zshrc.d/local-functions/darwin:$FPATH
        fi
        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                    ADMINISTRATOR DARWIN-SPECIFIC FUNCTIONS                      |
        # --------------------------------------------------------------------------------
        # These need to be invoked by an admin user.
            ## For admin and root user.
        if [[ $IS_ROOT ]]  ||  [[ $IS_ADMIN ]]; then
            ## Don't remove that anchor !
            #______##______#
            FCTLIST_SU_DARW=( grep-fs-open service MacOSDefaults \
                              KextLondoncalling LaunchLondoncalling MacOSDoctor MacOSHarden          \
                              flush_osx_cache update_supervisor sudo_open                            \
                              VirtualBox_Uninstall bluetooth dtrac bonjour dns                       \
                              exportfs group host_name plist domains_plist mdattr nfs                \
                              nsurlstorage ntp printer dhcp boot notification                        \
                              sync_fink timezone_handle unixify_rootfiles update user spotlight      \
                              firewall timestamp firewallapp )
            #______###______#
            ## Don't remove that anchor !
            local fctdarws
            foreach fctdarws in $FCTLIST_SU_DARW; do
                autoload -U $fctdarws
            done
            unset fctdarws
            unset fctdarws
            # typeset -xT SUDO_PATH sudo_path
             # sudo_path=($(/bin/ls -d $ZDOT/zshrc.d/local-functions/darwin/___\[SUDONEED\]___/*))
             # typeset -xT SUDO_PATH sudo_path
             # typeset -U sudo_path

                # if Apple someday includes an exportfs command, this should be
                # renamed or turned off (exportfs nfs_niloader )
                #alias nfs_automounter="nfs_niloader"
        ## For Debug
        zshrc_load_status "Administrator functions."
        fi # test for admin

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                           ADMINISTRATION DARWIN FUNCTIONS                      |
        # --------------------------------------------------------------------------------
        ## Don't remove that anchor !
        #______##______#
        FCTLIST_ADM_DARW=( loginitem  font-smoothing finkMakeListCache \
                           itcmd edit-keymapping mavericks-hacks lion-hacks                          \
                           invisible eject acl aeon dot wifi dashboard disk display                  \
                           dock errnum finder function_key_toggle gatekeeper battery numcpu          \
                           macosinfo keychain logout_user myip network ShowNetworkInterfaces         \
                           restart screensaver scrollspeed shutdown sleeep mdattr mlocate            \
                           breww casks  dot formulas install-osx taps fink fink_web  mybom           \
                           pd_adduser pd_injectuser islogin switch_users volume wallpaper )
        #______###______#
        ## Don't remove that anchor !
            local fctdarwa
            foreach fctdarwa in $FCTLIST_ADM_DARW; do
                autoload -U $fctdarwa
            done
            unset fctdarwa
        #export FCTLISTDARW="$FCTLIST_DARW"
        ## For Debug
        zshrc_load_status "Administration functions."

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                               DAILY_USE DARWIN FUNCTIONS                       |
        # --------------------------------------------------------------------------------

        ## Don't remove that anchor !
        #______##______#
        FCTLIST_DAI_DARW=( fdc termWindow termMultiTab trash     \
                           quit getbid zipit dir llock unixify_rootfiles  cdd cdf cds               \
                           cdsubl posgrep addIcon macmail mailit  osa_notification cpath            \
                           cpbcp cpos pbcp fdc posd posfind left right switcher toggle_spaces eds   \
                           ntab ntrm tab tcmd composer forklift mate powermate_control tmpj sd      \
                           MacRm rmm X11 )
        #______###______#
        ## Don't remove that anchor !
        local fctdarwdad
        foreach fctdarwdad in $FCTLIST_DAI_DARW; do
            autoload -U $fctdarwdad
        done
        unset fctdarwdad
        #export FCTLISTDARW="$FCTLIST_DARW"
         ## For Debug
         zshrc_load_status "Dailyuse functions."

        # wrapper needed for new _fink fast completions
        if [[ -d /sw/fink ]]; then
            autoload -U fink
            autoload -U fink_web
            autoload -U sync_fink
            alias finkweb='fink_web'
            ## For Debug
            zshrc_load_status "++Fink specific functions."
        fi

        # Terminal-ForkLift interactions
        if [[ -f  $HOME/Library/Preferences/com.binarynights.ForkLift.plist  ]]; then
            autoload -U forklift
            autoload -U cdright
            autoload -U cdlef

             ## For Debug
             zshrc_load_status "++Terminal-ForkLift interactions functions."

        fi
    #####
    #/!\#
    #####
        # TextMate.app project-opener command-line utility
        if [[ -f  $HOME/Library/Preferences/com.macromates.textmates.plist  ]]; then
            autoload -U tmpj # function to open saved projects with programmed completion
            autoload -U mate # wrapper opens html in Safari and TextMate simultaneously
            autoload -U cdt  # cd to directory in frontmost TextMate window
              ## For Debug
              zshrc_load_status "++TextMate.app project-opener functions for zsh."
        fi

        ####################
        # Growl-related functions (precommands)
        if [[ -x $(which growlnotify) ]]; then
            autoload -U gnotify
            autoload -U snotify
               ## For Debug
               zshrc_load_status "++Growl-related functions for zsh."
        fi

        # For VirtueDesktops and CodeTek Virtual Desktops
        # A function to switch desktops
        ##autoload -U sd
        if [[ "$(Z_OsxVersTest -b 10.5)" != 1  ]]; then
        # if [[ "$(Z_OsxVersTest.zwc -b 10.5)" != 1  ]]; then
        #if [[ $(sw_vers -productVersion) < 10.5 ]]; then
            /usr/bin/true
        else
            autoload -U toggle_spaces
            autoload -U switcher
        fi

        ####################
        # autoload open-x11 # Doesn't work correctly.  Use this workaround:
        function open-x11 {
            if [[ -f $P_SYSFCTDIR/darwin/open-x11 ]]; then
                $P_SYSFCTDIR/darwin/open-x11 "$@"
            elif [[ -f $ZDOT_TEMPLATE/zshrc.d/local-functions/darwin/open-x11 ]]; then
                $ZDOT_TEMPLATE/zshrc.d/local-functions/darwin/open-x11 "$@"
            else
                /usr/bin/open-x11 "$*"
            fi
         }

        ####################
        # set these associated aliases:
        alias cdf=""; unalias cdf   # make sure we don't use the wrong cdf
#####
#/!\#
#####
        alias opens='Z_Sudo_open'
#####
#/!\#
#####
        alias rmm='MacRm'           # Mac type remove function (Gary Kerbaugh)
        alias RmMac='MacRm'         # Dyslexics untie
        alias tidyx='tidyxml'       #
        # alias rm='MacRm -i'       # replaces the (interactive) rm command
        ####################

        # The command-line version is "dirstack" or cd\?.  Defined in $ZDOT/zshrc.d/aliases.local
        # alias cd\?="dirdump; typeset -U dirs_shared; dirstack"

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                DEVELOPPEMENT FUNCTIONS DARWIN FUNCTIONS                         |
        # --------------------------------------------------------------------------------
        ## Don't remove that anchor !
        #______##______#
        FCTLIST_DEV_DARW=( zaemonJail \
                           arduinoBuild web_dev xcode make_app \
                           image 32bitSafePerl mkicns pd_dot frameerrnum )
        #______###______#
        ## Don't remove that anchor !

        local fctdarwde
        foreach fctdarwde in $FCTLIST_DEV_DARW; do
            autoload -U $fctdarwde
        done
        unset fctdarwde


         zshrc_load_status "Development functions."

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                           MEDIA DARWIN FUNCTIONS                               |
        # --------------------------------------------------------------------------------
        ## Don't remove that anchor !
        #______##______#
        FCTLIST_MED_DARW=( isightcap da2preview a2preview itunelist )
        #______###______#
        ## Don't remove that anchor !

        local fctdarwm
        foreach fctdarwm in $FCTLIST_MED_DARW; do
            autoload -U $fctdarwm
        done
        unset fctdarwm


         zshrc_load_status "Media functions."

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                       NETWORK FUNCTIONS FUNCTIONS                              |
        # --------------------------------------------------------------------------------
        ## Don't remove that anchor !
        #______##______#
        FCTLIST_NET_DARW=( mustacheme spath firefox_window )
        #______###______#
        ## Don't remove that anchor !

        local fctdarwn
        foreach fctdarwn in $FCTLIST_NET_DARW; do
            autoload -U $fctdarwn
        done
        unset fctdarwn


         zshrc_load_status "Network functions."

        ###############################################################################
        ###############################################################################
        # --------------------------------
        #                                 \
        # ---------------------------------
        #          MOZCORE_DEBUG          |
        # ---------------------------------
        ##
        # uncomment for debugging
        zshrc_primary_load_status "Darwin functions set."
    fi   ## end ## [[ $LOAD_ESSENTIAL_FUNCTIONS == 'YES'   &&  $(uname) == Darwin ]]
        # Now clean up and remove any instances of multiple colons:
        FPATH=${FPATH/::/:}
        FPATH=${FPATH/::/:}
        FPATH=${FPATH/::/:}
        FPATH=${FPATH/::/:}
        FPATH=${FPATH/::/:}
        FPATH=${FPATH/::/:}
        FPATH=${FPATH/::/:}
        # Remove leading : if present
        FPATH=${FPATH#:}
        #
        # Export PATH as separate command to avoid dollar signs in export line
        #
        export FPATH
        #
        #
        # Avoid repeats in the fpath array
        #
        typeset -U fpath
fi ## end ## [[ -o interactive ]]
###############################################################################
