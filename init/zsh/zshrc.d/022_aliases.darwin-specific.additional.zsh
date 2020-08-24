# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#             $ZDOT/zshrc.d/022_aliases.darwin-specific.additional.zsh            |
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
# File :  ${ZDOT}/zshrc.d/022_aliases.darwin-specific.additional.zsh
# sourced from  /etc/zshrc
# Version : 2.0.0
# Specific Darwin aliases start here. You will probably want to edit this
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                     CHANGES
#---------------------------------------------------------------------------------
# 28/10/2017 :
# • Move this alias to 021_aliases.additional.zsh
#   #### EDIT/SOURCE RC FILES
#	alias zshrc="command nano $HOME/.zshrc"
#	alias nanorc='command sudo /usr/bin/pico /etc/nanorc'
#	alias rlzsh="source $HOME/.zshrc"
# 08/01/2018 :
# • Move all finder related alias to finder function.
# • Move all Security related alias to keychain function.
# • Move all dtrace related alias to dtrac function.
# 08/01/2018 :
# • Move all spotlight related alias to a spotlight function.
# 10/01/2018 :
# • Move all past Alf related alias to a firewallapp function.
# 18/07/2019 :
# • Add some alias
# 04/08/2019 :
# • Reoder and add some alias

#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------

################################################################################
################################################################################
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                 OSX ALIAS                                      |
# --------------------------------------------------------------------------------
if [[ -o interactive ]] && [[ $IS_MAC ]]; then
    ##uncomment to debug
    # {{{ Loading status
        zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
    #}}}

    # {{{ Loading status
        zshrc_load_status () { echo "${YEL}  + Darwin aliases load:${GREY} $*${NC}"}
    #}}}

    ##
    alias Volumes="cd /Volumes"

    ##
    alias ql='qlmanage -p 2>/dev/null' # OS X Quick Look
    alias 'today=calendar -A 0 -f /usr/share/calendar/calendar.mark | sort' alias 'mailsize=du -hs ~/Library/mail'
    alias 'smart=diskutil info disk0 | grep SMART' # display SMART status of hard drive
    # Hall of the Mountain King
    alias cello='say " di o io di o iodi o io di o iodi o io di o iodi o io di o iodi o io di o iodi o io di o iodi o io di o io"'
 
    # # alias to show all Mac App store apps
    alias apps='mdfind "kMDItemAppStoreHasReceipt=1"'
    # reset Address Book permissions in Mountain Lion (and later presumably)
    alias resetaddressbook='tccutil reset AddressBook'
    # refresh brew by upgrading all outdated casks
    alias refreshbrew='brew outdated | while read cask; do brew upgrade $cask; done'
    # rebuild Launch Services to remove duplicate entries on Open With menu
    alias rebuildopenwith='/System/Library/Frameworks/CoreServices.framework /Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'


    ###############################################################################
    ######### For my cd? command ##################################################
    # A synonym for "dirstack" that has to be an alias; naming a function
    # with a special character doesn't work (or is more trouble than it is worth).
    # gdirs is the corresponding GUI version of this, but works only on Mac OS X for now.
    alias cd\?="command dirdump; builtin typeset -U dirs_shared; dirstack"
    ###############################################################################

    # --------------------------------
    #                                 \
    # ---------------------------------
    #         COMMON OSX ALIAS         |
    # ---------------------------------
    #alias say="command say -v Zarvox"
    ###### CLEAN
    #### DSCACHEUTIL COMMAND
    # Flush Directory Service cache
    alias flush='command dscacheutil -flushcache && command killall -HUP mDNSResponder'

    #### LSREGISTER COMMAND
    # Clean up LaunchServices to remove duplicates in the “Open With” menu
    alias lsregisterclean='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && command killall Finder'
    alias lsregister='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister'
    #### RM COMMAND

    alias ql='qlmanage -p 2>/dev/null' # OS X Quick Look


    # Merge PDF files
    # Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
    alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

    # Empty the Trash on all mounted volumes and the main HDD
    # Also, clear Apple’s System Logs to improve shell startup speed
    #alias emptytrash="command sudo command rm -rfv /Volumes/*/.Trashes; command sudo command rm -rfv ~/.Trash; command sudo command rm -rfv /private/var/log/asl/*.asl"
    ### TRASH
    alias rtra="command rm -Rf /Users/$USER/.Trash/* 2>/dev/null ; command rm -Rf /Users/$USER/.Trash/.* 2>/dev/null"
    alias x="exit"
    alias xx="command rm /Users/$USER/.zsh/zsh_history /Users/$USER/.zsh/zsh_history_root /Users/$USER/.bash_history /Users/$USER/.history /Users/$USER/.zsh_history 2>/dev/null ; exit"
    alias xxx="xx && pkill iTerm2"


    ## Set a search path for the cd builtin
    cdpath=(.. ~)
    # MacPorts specific
    if [[ -d /opt || $HAS_PORT ]]; then

    fi
    # Homebrew specific
    if [[ -d /sw || $HAS_BREW ]]; then

    fi
    #### LS OSX COMMAND
    ### Some shell env to be sure that we have ls color on mac OSX.
    #alias ls="ls -GFlash"
    
    # View ACL
    alias lsacl='command ls -aeil'

    ## Logout, Restart, Shutdown (Shortcut ZaemonSH functions ):
    alias qq='logout_user'
    alias rr='restart'
    alias ss='shutdown'
    # --------------------------------
    #                                 \
    # ---------------------------------
    #          OSX APP LAUNCHER        |
    # ---------------------------------
    ##### OSX APP LAUNCHER
    #### Z_OPEN OPEN COMMAND
    alias o="open"
    alias oa="open -a"
    alias op="Z_Open -p"
    alias oo='command open .' # open current directory in OS X Finder
    alias of="command open -a Finder"
    alias Finderzombie='/System/Library/CoreServices/Finder.app/Contents/MacOS/Finder &'
    #alias FinderQuit="osascript -e 'tell app "Finder" to quit'"
    # TK
    alias Wish='command open "/System/Library/Frameworks/Tk.framework/Versions/8.5/Resources/Wish.app"'
    alias iStat="/Applications/Utilities/iStat\ Menus.app/Contents/Resources/InstallerBundle.bundle/Contents/Resources/iStat\ Menus\ Status.app/Contents/MacOS/iStat\ Menus\ Status &"
    
    # VMware Fusion
    alias fedovmstart="command vmrun -T fusion start /Volumes/macOSVM/Virtuals\ Machines/LINUX/FEDORA/Fedora\ 64.vmwarevm"
    alias fedovmstop="command vmrun -T fusion stop /Volumes/macOSVM/Virtuals\ Machines/LINUX/FEDORA/Fedora\ 64.vmwarevm"

    [[ $HAS_RANGER ]] && [[ -d /Volumes/MacOSData/DataBzz/ ]] && alias data="command ranger  /Volumes/MacOSData/DataBzz/"
    [[ -d /Volumes/MacOSVM/xhyve ]] && alias vm="command ranger  /Volumes/MacOSVM/xhyve"
    # --------------------------------
    #                                 \
    # ---------------------------------
    #       SECURITY MYALIAS           |
    # ---------------------------------
    #####FIREWALLAPP
    alias socketfilterfw='/usr/libexec/ApplicationFirewall/socketfilterfw'

    ### DSCACHEUTIL

    ### DSMEMBERUTIL COMMAND


    ### CODESIGN
    # Show default keychain

    ### SYSTEM-PROFILER COMMAND
    alias SystemProfilerFramework='builtin echo ""; builtin echo ${RED}"FRAMEWORKS INFO"${NC}; command system_profiler SPFrameworksDataType'
    alias SystemProfilerHardware='builtin echo ""; builtin echo "HARDWARE INFO"; command system_profiler SPHardwareDataType'
    ## ...
    # --------------------------------
    #                                 \
    # ---------------------------------
    #       OSX CUSTOMIZATION          |
    # ---------------------------------
    #### DEFAULTS COMMAND
    ## FINDER

    ## DASHBOARD
    # alias DashboardOff="command defaults write com.apple.dashboard mcx-disabled -bool YES"
    # alias DashboardON="command defaults write com.apple.dashboard mcx-disabled -bool ON"
    ## DISK UTILITY
    # Turn on expert mode in Disk Copy
    alias DiskUtilityExpertModeOn='command defaults write com.apple.diskcopy expert-mode -bool YES'
    alias DiskUtilityExpertModeOff='command defaults write com.apple.diskcopy expert-mode -bool NO'
    # Read Disk Copy expert mode flag
    alias DiskUtilityExpertStatus='command defaults read com.apple.diskcopy expert-mode'

    ## DMG (hdiutil)
    alias hdimount='hdiutil mount'
    alias hdidetach='hdiutil detach'
    alias forceeject='hdiutil detach -force'

    ## DOCK

    ## SAFARI

    #### OSASCRIPT COMMAND
    # Stuff I never really use but cannot delete either because of http://xkcd.com/530/
    alias soundMuted="command osascript -e 'set volume output muted true'"
    alias sound7="command osascript -e 'set volume 7'"

    ###### CRYPTO
    #### MD5 COMMAND
    # OS X has no `md5sum`, so use `md5` as a fallback
    command -v md5sum > /dev/null || alias md5sum="md5"
    #### SHA1
    # OS X has no `sha1sum`, so use `shasum` as a fallback
    command -v sha1sum > /dev/null || alias sha1sum="shasum"
    ####### PASTEBOARD
    #### PBCOPY COMMAND
    # Trim new lines and copy to clipboard
    alias c="command tr -d '\n' | command pbcopy"
    # copy the working directory path
    alias cpwd='command pwd | command tr -d "\n"| command pbcopy'
    alias gowd='cd "`pbpaste`"'

    # Process
    alias fs-usage='fs_usage -w -f filesys'

    ###### MYDIR SHORTCUT
    alias LibraryUser="command open  $HOME/Library"

    ###### FORENCIC
    # Show DYLD trace codes
    alias DYLDTraceCodes="command cat /usr/share/misc/trace.codes"

    ###### LSOF COMMAND
    # List open files
    alias lsofOpenFiles="command lsof -l +L -R -V"
    #-------------------------------------------
    #                                            \
    # --------------------------------------------
    #       NET/SERVEUR                           |
    # --------------------------------------------
    ### AIRPORT COMMAND
    # OSX Airport utility
    alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport'

    #-------------------------------------------
    #                                            \
    # --------------------------------------------
    #       DEVELOPPEMENT                         |
    # --------------------------------------------
    # JavaScriptCore REPL
    jscbin="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc";
    [ -e "${jscbin}" ] && alias jsc="${jscbin}";
    unset jscbin;
    # Merge PDF files
    # Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
    alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'
    # PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
    alias PlistBuddy="/usr/libexec/PlistBuddy"

    alias iosSimulator="command open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app"
    #alias python=/usr/bin/python
    alias python=/usr/local/bin/python

    ##AVR
    alias arduinoHeaders="ranger $HOME/Applications/Arduino.app/Contents/Java/hardware/arduino/avr/cores"
    alias avrHeaders="ranger $HOME/Applications/Arduino.app/Contents/Java/hardware/tools/avr/avr/include/"
    alias atmege329pRegisters="$EDITOR $HOME/Applications/Arduino.app/Contents/Java/hardware/tools/avr/avr/include/avr/iom328p.h"
    if [[ "$(whoami)" == "bzz"  ]]; then
        alias avrc="ranger $HOME/Desktop/Databzz/__ONAIR__/\[PROG\]/\[ARDUINO\]/\[C\]ARDUINO\]/"
    fi
    #_______________________________________________________________________

    # Add a transparent movable (and removable) space to the dock and restart it
    alias add_dock_space="command defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}' ; command killall Dock"

    # xpymol in fink (since "pymol" function maps to MacPyMOL)
    if [[ -x $SWPREFIX/lib/pymol-py25/bin/pymol ]];then
        alias xpymol="$SWPREFIX/lib/pymol-py25/bin/pymol"
    elif [[ -x $SWPREFIX/lib/pymol-py24/bin/pymol ]];then
        alias xpymol="$SWPREFIX/lib/pymol-py24/bin/pymol"
    elif [[ -x $SWPREFIX/lib/pymol-py26/bin/pymol ]];then
        alias xpymol="$SWPREFIX/lib/pymol-py26/bin/pymol"
    fi

    alias chess="/Applications/Chess.app/Contents/Resources/sjeng.ChessEngine"

 ################################################################################    ## For admin and root user.
    # --------------------------------
    #                                 \
    # ---------------------------------
    # SYSTEMADMINISTRATION ADMIN ALIAS |
    # ---------------------------------
    if [[ $IS_ROOT ]] ||  [[ $IS_ADMIN ]]; then
        #if [[ -n $(/usr/bin/id -p $USER | grep -w admin ) ]]; then
            #------OSX EXTRA PACKAGES MANAGER------#
            # Fink specific
            # if [[ -d /sw || -x $(which fink) ]]; then
            #     alias finkup='fink -y selfupdate ; fink -y update-all'
            #     alias aptup="sudo apt-get update; sudo apt-get dist-upgrade"
            #     alias flgrep='fink list -i'
        #fi

        # # Darwinports specific
        # if [[ -d /opt/local/darwinports || -x $(which port) ]]; then
        #     alias portup='sudo port -d selfupdate; sudo port -d upgrade installed'
        # fi

        # Macports specific
        if [[ $HAS_PORT ]]; then
            alias portc='sudo port clean --all installed'
            alias porti='sudo port install'
            alias ports='port search'
            alias portU='sudo port selfupdate && sudo port upgrade outdated'
            alias portu='sudo port upgrade'
            alias portX='sudo port -u uninstall'
            alias portx='sudo port uninstall'
        fi

        #####SPOTlIGHT
        # Disable Spotlight
        alias spotoff="sudo mdutil -a -i off"
        # Enable Spotlight
        alias spoton="sudo mdutil -a -i on"

        #####ALF


        ##### NETWORKSETUP COMMAND
        # turn ethernet on/off
        alias ethoff="command sudo -S command networksetup setnetworkserviceenabled 'Ethernet 1' off"
        alias ethon="command sudo -S command networksetup setnetworkserviceenabled 'Ethernet 1' on"
        # --------------------------------
        #                                 \
        # ---------------------------------
        #         SERVEUR ADMIN ALIAS      |
        # ---------------------------------
        ### APACHECTL
        ## Control web servers
        # also pass it via sudo so whoever is admin can reload it without calling you #
        alias httpdreload='command sudo command apachectl -k graceful'
        alias httpdtest='command sudo command apachectl -t && command apachectl -t -D DUMP_VHOSTS'
        # --------------------------------
        #                                 \
        # ---------------------------------
        #      FORENSICS ADMIN ALIAS       |
        # ---------------------------------
    fi
    ## END of admine
    # --------------------------------
    #                                 \
    # ---------------------------------
    #          MOZCORE_DEBUG          |
    # ---------------------------------
    # uncomment this for debugging purposes or verbose startup:
    zshrc_primary_load_status "Darwin specifics aliases set."
fi
## END interactive

