#! /usr/bin/env zsh

######################################################################################################
#                                                                                                    #
#    ZAEMONSH Created by Zucchelli Bryan && @N@TOME && Admiral Gr@ss H0pper on Oct 13, 2017.         #
#    Copyright (c) 2017. All rights reserved.                                                        #
#    Hardly inspired by zsh-templates created by William Scott on May 11, 2007.                      #
#    Copyright (c) 2007. All rights reserved.                                                        #
#                                                                                                    #
#    This program is free software; you can redistribute it and/or modify                            #
#    it under the terms of the GNU General Public License as published By                            #
#    the Free Software Foundation; either version 2 of the License, or                               #
#    (at your option) any later version.                                                             #
#                                                                                                    #
#    This program is distributed in the hope that it will be useful,                                 #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of                                  #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                                   #
#    GNU General Public License for more details.                                                    #
#                                                                                                    #
#    You should have received a copy of the GNU General Public License                               #
#    along with this program; if not, write to the Free Software                                     #
#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301                       #
#    USA                                                                                             #
#                                                                                                    #
#    cf. URL:   http://www.fsf.org/licensing/licenses/gpl.html                                       #
#                                                                                                    #
######################################################################################################

#----------------------------------------------------------------------------------------#
#                                     DESCRIPTION
#----------------------------------------------------------------------------------------#
# InstallZaemonSH :
# ON OS X, you can install for the system:

# 	sudo cp -R Library/init  ~/Library/.
# 	sudo cp  etc/zshenv  /etc/zshenv
# 	sudo cp  etc/zshrc  /etc/zshrc

# 	or for an individual user:

# 	cp -R Library/init  ~/Library/.
# 	cp  etc/zshenv ~/.zshenv
# 	cp  etc/zshrc ~/.zshrc

# ON Linux, I've only tried it this way, and only on Ubuntu Linux:

# 	sudo mkdir -p /etc/zsh
# 	sudo cp -R Library/init /etc/zsh/.
# 	sudo cp  etc/zshenv  /etc/zsh/zshenv
# 	sudo cp  etc/zshrc  /etc/zsh/zshrc

# depending on how zsh was built, you might need to
# issue the following commands to get it to work:

# 	sudo ln -s /etc/zsh/zshenv  /etc/zshenv
# 	sudo ln -s /etc/zsh/zshrc  /etc/zshrc

# it might be possible to set it up on Linux for the
# individual user using a scheme similar to what was
# give for the Mac OS X example.

#----------------------------------------------------------------------------------------#
#                                        TODO
#----------------------------------------------------------------------------------------#
# 23/10/2017 :
# • Change the installation destination path for init folder (to $HOME/.config/ini
# 23/10/2017 :
# • Add NerdFont with  ln -s $P_SYSETCDIR/Fonts/NerdFonts $HOME/Library/Fonts/NerdFont
# • Add dots files
# • Make a log file for installer
# 21/02/2020 :
# • Verify permissions
# 2020-02-22 :
# • Change Linux installation

#----------------------------------------------------------------------------------------#
#                                       CHANGES
#----------------------------------------------------------------------------------------#
# 19/10/2017 :
#  • Modify script presentation.
#  • Define some command variables.
#  • Clean script.
#  • Move --> #! /usr/bin/env zsh -f for  #! /usr/bin/env zsh to be portable with linux
# 22/10/2017 :
#  • Better scripting for linux and darwin part and testing.(Add readable variables correponding
#  	 to those find in Z_Backup)
#  • Test on Darwin and Linux.
# 23/10/2017 :
#  • Change chown "$USER":staff to chown "$USER":"$USER" on linux install function.
#  • Add an "exec zsh" at end of script to immediately launch GUI configure_zsh after this installation.
#  • Move local on function.
# 13/01/2018 :
#  • Add zip regex in symlinks recreation.
#  • Correct $ZDOT/bin permissions problem when ZaemonSH is backup in one user and install with another.
# 16/07/2019
#  • Correct binaries symlinks on both linux and mac install
#  • Add remove old symlinks on pre-intall.
# 01/08/2019
#  • Remove last erase symlinks routine.
# 17/09/2019
#  • Add Launch Agents file to speed open command and his completion.
# 2020-02-22 :
# • Change Darwin installation
# 2020-02-28 :
# • Change symlinked by copied Nerd Fonts.

#----------------------------------------------------------------------------------------#
#                                       CONFIG
#----------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------#
#                                      FUNCTIONS
#----------------------------------------------------------------------------------------#
banner () {
	# Define some colors first:
	local GREEN=$'\033[1;32m'
	local YEL=$'\033[1;33m'
	local RED=$'\033[1;31m'
	local NC=$'\033[0m'
	local VERSION="0.0.1"
	local NAME="InstallZaemonSH"
    #local ZAEM_ACTNB_VERS=$(grep "ZAEMONSHVERSION=" $ZAEM_ZSHRC_PATH 2>/dev/null | sed 's/.*=//')
	#local ZAEM_NEWNB_VERS=$(($ZAEM_ACTNB_VERS+1))
    clear


    echo "${NC}"
	echo " ###################################################################################################"
	echo " #                                                                                                 #"
	echo " #     ${GREEN}This is ${RED}$NAME : ${YEL}$VERSION FOR $OSTYPE ${NC}                                                  #"
	echo " #     CopyL®®v 2017, Zucchelli Bryan                                                              #"
	echo " #                                                                                                 #"
	echo " #     Unless required by applicable law or agreed to in writing, software                         #"
	echo " #     distributed under the License is distributed on an "AS IS" BASIS,                             #"
	echo " #     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.                    #"
	echo " #     See the License for the specific language governing pe$RMissions and                                  #"
	echo " #     limitations under the License.                                                              #"
	echo " #                                                                                                 #"
	echo " ###################################################################################################"
	echo ""
}

#{{{ ZAEMONSH_DarwinInstall () {
ZAEMONSH_DarwinInstall () {
    [[ ! $(echo "${$(pwd):t}") =~ ^(ZAEMONSH-)+ ]] && echo "${WB} Installer file is in an exotic word" && return 1

    #####################################
    ## DARWIN ZAEMON INSTALL VARIABLES ##
    #####################################

    ## ZAEMONSH VARIABLES ##
    local ZAEM_INIT_PATH="$HOME/Library/init" ##

    ## RANGER VARIABLES
    local ZAEM_RANGERC_PATH="$HOME/.config/ranger"

    ## ZAEMON LAUNCHAGENT ##
    local ZAEM_LAUNCHAGENT_PATH="$HOME/Library/init/zsh/zshrc.d/local-functions/etc/installer/launchAgents"

    ## FONTS VARIABLES
    local ZAEM_FONTS_PATH="$HOME/Library/init/zsh/zshrc.d/local-functions/etc/Fonts/"

    local WB="\033[31m [ WARNING ]"
    local WG="\033[32m [ OK ]"
    local WN="\033[36m [ NOTHING TO DO ]"

    ##
    DOT_LIST=( $(ls -A . | grep -v "InstallZaemonSH.zsh\|ranger\|init\|.gdbinit.local\|.zshrc") )
    ########################################


    ########################################
    clear
    echo ""
    echo ""
    echo "##########################################################"
    echo "   # STARTING ZAEMONSH INSTALLATION FOR DARWIN. #"
    echo "##########################################################"
    echo ""
    echo ""
    sleep 2

    [[ $HOME/.zsh ]] && rm -Rf $HOME/.zsh

    clear
    echo ""
    echo "##########################################################"
    echo "# ZAEMON FILES AND DOTS FILES. #"
    echo "##########################################################"

    for fileList in $DOT_LIST; do
              ## ERASE ORIGINAL FILE.
              echo " # We erase old $fileList. #"
              [[ -e $HOME/$fileList ]] && rm -Rf $HOME/$fileList && echo "${WG} Old $fileList erased.${NC}" || echo "${WN}${NC}"
              ## COPY NEW FILE
              echo " # We copy new $fileList configuration. #"
              mv $fileList $HOME/$fileList
              echo "${WG} New $fileList copied.${NC}"
              echo ""
    done


    for fileListo in $(ls -A .); do
        case $fileListo in
            \.init)
                 ## ERASE ZAEMON INIT FOLDER.
                 echo ""
                 echo " # We erase old $fileListo folder. #"
                 [[ -e "$ZAEM_INIT_PATH" ]] && rm -Rf "$ZAEM_INIT_PATH" 2>/dev/null || echo "${WN}${NC}"
                 ## COPY ZAEMONSH INIT FOLDER
                 echo " # We copy new $fileListo ZAEMONSH installation folder. #"
                 [[ $(pwd)/$fileListo ]] &&  mv -f $fileListo $ZAEM_INIT_PATH 2>/dev/null
                 [[ $(pwd)/$fileListo ]] &&  mv -f $fileListo $ZAEM_INIT_PATH 2>/dev/null;
                 echo "${WG} New $fileListo installed.${NC}"
            ;;
            init)
                 ## ERASE ZAEMON INIT FOLDER.
                 echo ""
                 echo " # We erase old $fileListo folder. #"
                 [[ -e "$ZAEM_INIT_PATH" ]] && rm -Rf "$ZAEM_INIT_PATH" 2>/dev/null || echo "${WN}${NC}"
                 ## COPY ZAEMONSH INIT FOLDER
                 echo " # We copy new $fileListo ZAEMONSH installation folder. #"
                 [[ $(pwd)/$fileListo ]] &&  mv -f $fileListo $ZAEM_INIT_PATH 2>/dev/null
                 [[ $(pwd)/$fileListo ]] &&  mv -f $fileListo $ZAEM_INIT_PATH 2>/dev/null;
                 echo "${WG} New $fileListo installed.${NC}"
            ;;
            ranger)
                 ## ERASE RANGER FOLDER.
                 echo ""
                 echo " # We erase old $fileListo folder. #"
                 [[ -e $HOME/.config/$fileListo ]] && rm -Rf $HOME/.config/$fileListo || echo "${WN}${NC}"
                  echo " # We copy new $fileListo configuration files. #"
                  [[ $(pwd)/$fileListo ]] &&  mv -f $fileListo $HOME/.config/$fileListo 2>/dev/null
                  echo "${WG} New $fileListo installed.${NC}"
            ;;
            \.zshrc-*)
                 ## ERASE OLD ZSHRC
                 echo ""
                 echo " # We erase old $fileListo folder. #"
                 [[ -e "$HOME/$fileListo" ]] && rm -Rf $HOME/$fileListo || echo "${WN}${NC}"
                 ## COPY NEW ZSHRC
                 echo " # We copy new $fileListo. #"
                 [[ $(pwd)/$fileListo ]] &&  mv -f $fileListo $HOME/.zshrc
                 echo "${WG} New $fileListo installed.${NC}"
            ;;
            \.gdbinit.local)
                 ## ERASE OLD ZSHRC
                 echo ""
                 echo " # We erase old $fileListo folder. #"
                 [[ -e "$HOME/$fileListo" ]] && rm -Rf $HOME/$fileListo || echo "${WN}${NC}"
                 ## COPY NEW ZSHRC
                 echo " # We copy new $fileListo. #"
                 [[ $(pwd)/$fileListo ]] &&  mv -f $fileListo $HOME/.gdbinit.local
                 echo "${WG} New $fileListo installed.${NC}"
            ;;
        esac
    done

    sleep 2
    clear
    echo ""
    echo "##########################################################"
    echo "# SYMLINKING AND COMPILING FUNCTIONS. #"
    echo "##########################################################"
    local P_SYSFCTDIR="$HOME/Library/init/zsh/zshrc.d/local-functions"
    echo "  >> We erased old ZaemonSH binaries and compiled functions symlinks for Darwin.${RED}"
    find $HOME/Library/init/zsh/zshrc.d/local-functions -type l -exec rm -f {} \;
    find $HOME/Library/init/zsh/zshrc.d/local-functions -type f -name "*.zwc" -exec rm -f {} \;
    echo "${NC}  >> We correct ZaemonSH binaries and functions symlinks for Darwin. "
    echo "${LINE}"
    for systemtype in core darwin universal; do
        sleep 1
        clear
        echo "${RED}--systemtype=$systemtype${NC}"
        for zed in $(find $P_SYSFCTDIR/$systemtype  -name "*.zwc" ); do rm -f $zed; done
        find $P_SYSFCTDIR/$systemtype -type l -exec rm {} \;
            for zud in $( find $P_SYSFCTDIR/$systemtype \! -name "*.zip" -type f | grep -v "DS_Store" | grep -v "___000_README.txt" | grep -v ".zwc$" ); do
                # echo "--zud=$zud"
                ln -s $zud $P_SYSFCTDIR/$systemtype
                for zid in $(echo ${${zud##*/}%.*} | grep -v "^_"); do
                    # Since version 4.1.7, it has been possible to compile functions to their
                    # internal format. It doesn’t make the functions run any faster, it just reduces
                    # their loading time; the shell just has to bring the function into memory,
                    # then it ‘runs it as it does any other function.
                    # echo "" && echo "$zud";
                    if [[ -e $zud.zwc ]]; then
                        echo "${WG} ${NC}$zid.zwc function already compiled."
                        echo "${GREEN} zrecompiling $zid ...${NC}"
                        wait
                        zrecompile "$zud"
                        wait
                        echo "${WG} ${NC}$zid function recompiled."
                        wait
                    else
                        echo "${GREEN} Compiling $zid ...${RED}"
                        wait
                        zcompile -U "$zud"
                        wait
                        echo "${NC}${WG} ${NC}$zid function ${GREEN}compiled.${NC}"
                        wait
                    fi
                    cp $zud.zwc $P_SYSFCTDIR/$systemtype
                    wait
                    echo "${WG} ${NC}$zid compiled function copy completed."
                done
             done
        echo ""
        echo "${GREEN}  • $systemtype symlinks functions are corrected.${NC}"
        # Debug
        # echo "${BRED}"
        echo ""
    done

    sleep 2
    clear
    echo ""
    echo "##########################################################"
    echo "# SYMLINKING BINARY. #"
    echo "##########################################################"
    ## ERASE OLD BIN SYMLINKS
    echo " # We erase old bin symlinks. #"
    find $ZAEM_INIT_PATH/zsh/bin -maxdepth 1 -type l -exec rm {} \;
    echo " # Old bin symlinks erasing done. #"
    ## REMAKE SYMLINKS
    for sim in $(find $ZAEM_INIT_PATH/zsh/bin \! -name "*.zip" -maxdepth 3 -type f | grep -v "DS_Store" | grep -v   ".pl" | grep -v "___LINUX") ; do
        chown "$USER":staff $sim
        chmod go-rwx $sim
        ln -s $sim $ZAEM_INIT_PATH/zsh/bin
    done

    sleep 2
    clear
    echo ""
    echo "##########################################################"
    echo "# LAUNCHING ZAEMONSH AGENT. #"
    echo "##########################################################"
    ## COPY ZAEMONSH LAUNCHAGENTS
    #cp ZAEM_LAUNCHAGENT_PATH/zsh.fink.completion.plist $HOME/Library/LaunchAgents
    [[ -e $HOME/Library/LaunchAgents/zsh.open.completion.plist ]] && rm $HOME/Library/LaunchAgents/zsh.open.completion.plist
    cp $ZAEM_INIT_PATH/zsh/zshrc.d/local-functions/etc/installer/launchAgents/zsh.open.completion.plist $HOME/Library/LaunchAgents
    launchctl load -w $HOME/Library/LaunchAgents/zsh.open.completion.plist
    ##
    [[ -e $HOME/Library/LaunchAgents/zsh.refresh.completion.plist ]] && rm $HOME/Library/LaunchAgents/zsh.refresh.completion.plist
    cp $ZAEM_INIT_PATH/zsh/zshrc.d/local-functions/etc/installer/launchAgents/zsh.refresh.completion.plist $HOME/Library/LaunchAgents
    launchctl load -w $HOME/Library/LaunchAgents/zsh.refresh.completion.plist

    sleep 2
    clear
    echo ""
    echo "##########################################################"
    echo "# SYMLINKING ZAEMONSH FONTS. #"
    echo "##########################################################"
    ## MAKE FONTS SYMLINKS
    rm -f $HOME/Library/Fonts/Droid*
    cp  $HOME/Library/init/zsh/zshrc.d/local-functions/etc/Fonts/NerdFonts/Droid* $HOME/Library/Fonts/
    # ln -s $HOME/Library/init/zsh/zshrc.d/local-functions/etc/Fonts/NerdFonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete\ Mono.otf $HOME/Library/Fonts/
    # ln -s $HOME/Library/init/zsh/zshrc.d/local-functions/etc/Fonts/NerdFonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf $HOME/Library/Fonts/

	rm -Rf "$(pwd)"

	echo "${GREEN} ZAEMONSH installation done. ${NC}"
	echo ""
	sleep 2
    clear
}
#}}}



#{{{ ZAEMONSH_LinuxInstall () { 
ZAEMONSH_LinuxInstall () { 
    [[ ! $(echo "${$(pwd):t}") =~ ^(ZAEMONSH-)+ ]] && echo "${WB} Installer file is in an exotic word" && return 1

    #####################################
    ## LINUX ZAEMON INSTALL VARIABLES ##
    #####################################

    ## ZAEMONSH VARIABLES ##
    local ZAEM_INIT_PATH="$HOME/.init" ##

    ## RANGER VARIABLES
    local ZAEM_RANGERC_PATH="$HOME/.config/ranger"



    local WB="\033[31m [ WARNING ]"
    local WG="\033[32m [ OK ]"
    local WN="\033[36m [ NOTHING TO DO ]"

    ##
    DOT_LIST=( $(ls -A . | grep -v "InstallZaemonSH.zsh\|ranger\|init\|.gdbinit.local\|.zshrc") )
    ########################################


    ########################################
    clear
    echo ""
    echo ""
    echo "##########################################################"
    echo "   # STARTING ZAEMONSH INSTALLATION FOR LINUX. #"
    echo "##########################################################"
    echo ""
    echo ""
    sleep 2

    [[ $HOME/.zsh ]] && rm -Rf $HOME/.zsh

    clear
    echo ""
    echo "##########################################################"
    echo "# ZAEMON FILES AND DOTS FILES. #"
    echo "##########################################################"

    for fileList in $DOT_LIST; do
              ## ERASE ORIGINAL FILE.
              echo " # We erase old $fileList. #"
              [[ -e $HOME/$fileList ]] && rm -Rf $HOME/$fileList && echo "${WG} Old $fileList erased.${NC}" || echo "${WN}${NC}"
              ## COPY NEW FILE
              echo " # We copy new $fileList configuration. #"
              mv $fileList $HOME/$fileList
              echo "${WG} New $fileList copied.${NC}"
              echo ""
    done


    for fileListo in $(ls -A .); do
        case $fileListo in
            \.init)
                 ## ERASE ZAEMON INIT FOLDER.
                 echo ""
                 echo " # We erase old $fileListo folder. #"
                 [[ -e "$ZAEM_INIT_PATH" ]] && rm -Rf "$ZAEM_INIT_PATH" 2>/dev/null || echo "${WN}${NC}"
                 ## COPY ZAEMONSH INIT FOLDER
                 echo " # We copy new $fileListo ZAEMONSH installation folder. #"
                 [[ $(pwd)/$fileListo ]] &&  mv -f $fileListo $ZAEM_INIT_PATH 2>/dev/null
                 [[ $(pwd)/$fileListo ]] &&  mv -f $fileListo $ZAEM_INIT_PATH 2>/dev/null;
                 echo "${WG} New $fileListo installed.${NC}"
            ;;
            init)
                 ## ERASE ZAEMON INIT FOLDER.
                 echo ""
                 echo " # We erase old $fileListo folder. #"
                 [[ -e "$ZAEM_INIT_PATH" ]] && rm -Rf "$ZAEM_INIT_PATH" 2>/dev/null || echo "${WN}${NC}"
                 ## COPY ZAEMONSH INIT FOLDER
                 echo " # We copy new $fileListo ZAEMONSH installation folder. #"
                 [[ $(pwd)/$fileListo ]] &&  mv -f $fileListo $ZAEM_INIT_PATH 2>/dev/null
                 [[ $(pwd)/$fileListo ]] &&  mv -f $fileListo $ZAEM_INIT_PATH 2>/dev/null;
                 echo "${WG} New $fileListo installed.${NC}"
            ;;
            ranger)
                 ## ERASE RANGER FOLDER.
                 echo ""
                 echo " # We erase old $fileListo folder. #"
                 [[ -e $HOME/.config/$fileListo ]] && rm -Rf $HOME/.config/$fileListo || echo "${WN}${NC}"
                  echo " # We copy new $fileListo configuration files. #"
                  [[ $(pwd)/$fileListo ]] &&  mv -f $fileListo $HOME/.config/$fileListo 2>/dev/null
                  echo "${WG} New $fileListo installed.${NC}"
            ;;
            \.zshrc-*)
                 ## ERASE OLD ZSHRC
                 echo ""
                 echo " # We erase old $fileListo folder. #"
                 [[ -e "$HOME/$fileListo" ]] && rm -Rf $HOME/$fileListo || echo "${WN}${NC}"
                 ## COPY NEW ZSHRC
                 echo " # We copy new $fileListo. #"
                 [[ $(pwd)/$fileListo ]] &&  mv -f $fileListo $HOME/.zshrc
                 echo "${WG} New $fileListo installed.${NC}"
            ;;
            \.gdbinit.local)
                 ## ERASE OLD ZSHRC
                 echo ""
                 echo " # We erase old $fileListo folder. #"
                 [[ -e "$HOME/$fileListo" ]] && rm -Rf $HOME/$fileListo || echo "${WN}${NC}"
                 ## COPY NEW ZSHRC
                 echo " # We copy new $fileListo. #"
                 [[ $(pwd)/$fileListo ]] &&  mv -f $fileListo $HOME/.gdbinit.local
                 echo "${WG} New $fileListo installed.${NC}"
            ;;
        esac
    done

    sleep 2
    clear
    echo ""
    echo "##########################################################"
    echo "# SYMLINKING AND COMPILING FUNCTIONS. #"
    echo "##########################################################"
    local P_SYSFCTDIR="$HOME/.init/zsh/zshrc.d/local-functions"
    echo "  >> We erased old ZaemonSH binaries and compiled functions symlinks for Darwin.${RED}"
    find $HOME/.init/zsh/zshrc.d/local-functions -type l -exec rm -f {} \;
    find $HOME/.init/zsh/zshrc.d/local-functions -type f -name "*.zwc" -exec rm -f {} \;
    echo "${NC}  >> We correct ZaemonSH binaries and functions symlinks for Darwin. "
    echo "${LINE}"
    for systemtype in core linux universal; do
        sleep 1
        clear
        echo "${RED}--systemtype=$systemtype${NC}"
        for zed in $(find $P_SYSFCTDIR/$systemtype  -name "*.zwc" ); do rm -f $zed; done
        find $P_SYSFCTDIR/$systemtype -type l -exec rm {} \;
            for zud in $( find $P_SYSFCTDIR/$systemtype \! -name "*.zip" -type f | grep -v "DS_Store" | grep -v "___000_README.txt" | grep -v ".zwc$" | grep -v "OSX" ); do
                # echo "--zud=$zud"
                ln -s $zud $P_SYSFCTDIR/$systemtype
                for zid in $(echo ${${zud##*/}%.*} | grep -v "^_"); do
                    # Since version 4.1.7, it has been possible to compile functions to their
                    # internal format. It doesn’t make the functions run any faster, it just reduces
                    # their loading time; the shell just has to bring the function into memory,
                    # then it ‘runs it as it does any other function.
                    # echo "" && echo "$zud";
                    if [[ -e $zud.zwc ]]; then
                        echo "${WG} ${NC}$zid.zwc function already compiled."
                        echo "${GREEN} zrecompiling $zid ...${NC}"
                        wait
                        zrecompile "$zud"
                        wait
                        echo "${WG} ${NC}$zid function recompiled."
                        wait
                    else
                        echo "${GREEN} Compiling $zid ...${RED}"
                        wait
                        zcompile -U "$zud"
                        wait
                        echo "${NC}${WG} ${NC}$zid function ${GREEN}compiled.${NC}"
                        wait
                    fi
                    cp $zud.zwc $P_SYSFCTDIR/$systemtype
                    wait
                    echo "${WG} ${NC}$zid compiled function copy completed."
                done
             done
        echo ""
        echo "${GREEN}  • $systemtype symlinks functions are corrected.${NC}"
        # Debug
        # echo "${BRED}"
        echo ""
    done

    sleep 2
    clear
    echo ""
    echo "##########################################################"
    echo "# SYMLINKING BINARY. #"
    echo "##########################################################"
    ## ERASE OLD BIN SYMLINKS
    echo " # We erase old bin symlinks. #"
    find $ZAEM_INIT_PATH/zsh/bin -maxdepth 1 -type l -exec rm {} \;
    echo " # Old bin symlinks erasing done. #"
    ## REMAKE SYMLINKS
    for sim in $(find $ZAEM_INIT_PATH/zsh/bin -maxdepth 3 \! -name "*.zip"  -type f | grep -v "DS_Store" | grep -v   ".pl" | grep -v "___OSX") ; do
        chown "$USER":"$USER" $sim
        chmod go-rwx $sim
        ln -s $sim $ZAEM_INIT_PATH/zsh/bin
    done

    sleep 2
    clear
	rm -Rf "$(pwd)"

	echo "${GREEN} ZAEMONSH installation done. ${NC}"
	echo ""
	sleep 2
    clear     
}
#}}}


###{{{ ZAEMONSH_LinuxInstallBack () {
ZAEMONSH_LinuxInstallBack () {
	# Define some colors first:
	local GREEN=$'\033[1;32m'
	local NC=$'\033[0m'
	###################################
	## LINUX ZAEMON BACKUP VARIABLES ##
	###################################

	## ZAEMONSH VARIABLES ##
	local ZAEM_ZSHRC_PATH="$HOME/.zshrc" ##
	local ZAEM_ZSH_PATH="$HOME/.zsh" ##
	local ZAEM_INIT_L_PATH="$HOME/.init" ##

	## VIM VARIABLES ##
	local ZAEM_VIMRC_PATH="$HOME/.vimrc" ##
	local ZAEM_VIMFOLD_PATH="$HOME/.vim_runtime" ##

	## NANO VARIABLES ##
	local ZAEM_NANORC_PATH="$HOME/.nanorc" ##
	local ZAEM_NANOFOLD_PATH="$HOME/.nano" ##
	####################

	echo "################################################################"
	echo " # Before all, we erase all past ZeamonSH configuration files. #"
	echo "################################################################"
	echo ""
	## Erase .zshrc file.
	if [[ -e $ZAEM_ZSHRC_PATH ]]; then
		rm -Rf $ZAEM_ZSHRC_PATH 2>/dev/null
	else
		echo "${GREEN}NOTHING TO DO${NC}"
		:
	fi

	## Erase .zsh folder.
	if [[ -e $ZAEM_ZSH_PATH ]]; then
		rm -Rf "$ZAEM_ZSH_PATH" 2>/dev/null
	else
		echo "${GREEN}NOTHING TO DO${NC}"
		:
	fi

	## Erase init folder.
	if [[ -e "$ZAEM_INIT_L_PATH" ]]; then
		rm -Rf "$ZAEM_INIT_L_PATH" 2>/dev/null
	else
		echo "${GREEN}NOTHING TO DO${NC}"
		:
	fi

	## Erase zsh folder.
	if [[ -e "$HOME/.zcompdump" ]]; then
		rm  "$HOME/.zcompdump" 2>/dev/null
	else
		echo "${GREEN}NOTHING TO DO${NC}"
		:
	fi

	## Erase vimrc file.
	if [[ -e $ZAEM_VIMRC_PATH ]]; then
		rm -Rf "$ZAEM_VIMRC_PATH" 2>/dev/null
	else
		echo "${GREEN}NOTHING TO DO${NC}"
		:
	fi

	## Erase vim folder.
	if [[ -e $ZAEM_VIMFOLD_PATH ]]; then
		rm -Rf "$ZAEM_VIMFOLD_PATH" 2>/dev/null
	else
		echo "${GREEN}NOTHING TO DO${NC}"
		:
	fi

	## Erase nanorc file.
	if [[ -e $ZAEM_NANORC_PATH ]]; then
		rm -Rf "$ZAEM_NANORC_PATH" 2>/dev/null
	else
		echo "${GREEN}NOTHING TO DO${NC}"
		:
	fi

	## Erase nano folder.
	if [[ -e $ZAEM_NANOFOLD_PATH ]]; then
		rm -Rf "$ZAEM_NANOFOLD_PATH" 2>/dev/null
	else
		echo "${GREEN}NOTHING TO DO${NC}"
		:
	fi

    ## Erase old function symlinks
    find $P_SYSFCTDIR -mindepth 2 -type l -exec rm {} \;;

    ## Erase old bin symlinks
    find $ZDOT/bin -mindepth 1 -type l -exec rm {} \;;


	echo " ${GREEN} # All past ZeamonSH configuration files erased. ${NC}#"
	echo ""
	echo "##########################################################"
	echo "   # We starting ZAEMONSH installation on Linux system. #"
	echo "##########################################################"
	echo ""
	echo " # We cd to the ZaemonSH installation folder. #"
	cd .
	echo " ${GREEN} # We are on the ZaemonSH installation folder. # ${NC}"
	echo ""

	## COPY ZAEMONSH FILES
	echo " # We copy new init ZAEMONSH installation files. #"
	if [ $(pwd)/init ]; then mv -f init $ZAEM_INIT_L_PATH 2>/dev/null; else : ; fi
	if [ $(pwd)/.init ]; then mv -f .init $ZAEM_INIT_L_PATH 2>/dev/null; else : ; fi
	echo " ${GREEN} # New init ZAEMONSH installation files installed. # ${NC}"
	echo ""

	## CORRECT ZAEMONSH SYMLINKS FUNCTIONS
	echo " # We correct symlinks of functions files. #"
	echo " Step 1 : Correct core symlinks functions."
	# echo " - We erase all old core symlinks."
	find $ZAEM_INIT_L_PATH/zsh/zshrc.d/local-functions/core -type l -exec rm {} \;
	#echo " ${GREEN} All old core symlinks are erased now.${NC}"
	#echo " And finally, we remake new good core symlinks."
	for zad in $(find $ZAEM_INIT_L_PATH/zsh/zshrc.d/local-functions/core \! -name "*.zip" -type f | grep -v ".DS_Store"  |  grep -v "___000_README.txt" |  grep -v "OSX"); do
	 	chmod -x $zad
	 	wait
	 	chown "$USER":"$USER" $zad
	 	chmod go-rwx $zad
        wait
	 	ln -s $zad $ZAEM_INIT_L_PATH/zsh/zshrc.d/local-functions/core
	done
	echo " Step 1 : ${GREEN} All core corrections done. ${NC}"
	echo ""
	echo " Step 2 : Correct linux symlinks functions."
	# echo " - We erase all old darwin symlinks."
	find $ZAEM_INIT_L_PATH/zsh/zshrc.d/local-functions/linux -type l -exec rm {} \;
	# echo " ${GREEN} All old darwin symlinks are erased now. ${NC}"
	# echo " And finally, we remake new good  darwin symlinks."
	for zid in $(find $ZAEM_INIT_L_PATH/zsh/zshrc.d/local-functions/linux \! -name "*.zip" -type f | grep -v ".DS_Store" |  grep -v "___000_README.txt" ); do
		chmod -x $zid
	 	wait
	 	chown "$USER":"$USER" $zid
	 	chmod go-rwx $zid
        wait
		ln -s $zid $ZAEM_INIT_L_PATH/zsh/zshrc.d/local-functions/linux
	done
	echo " Step 2 : ${GREEN} All linux corrections done. ${NC}"
	echo ""
	echo " Step 3 : Correct universal symlinks functions."
	# echo " - We erase all old universal symlinks."
	find $ZAEM_INIT_L_PATH/zsh/zshrc.d/local-functions/universal -type l -exec rm {} \;
	# echo " ${GREEN} All old universal symlinks are erased now. ${NC}"
	# echo " And finally, we remake new good universal symlinks."
	for zud in $(find $ZAEM_INIT_L_PATH/zsh/zshrc.d/local-functions/universal \! -name "*.zip" -type f | grep -v ".DS_Store" |  grep -v "___000_README.txt" ); do
		chmod -x $zud
	 	wait
	 	chown "$USER":"$USER" $zud
	 	chmod go-rwx $zud
        wait
		ln -s $zud $ZAEM_INIT_L_PATH/zsh/zshrc.d/local-functions/universal
	done
	echo " Step 3 : ${GREEN} All universal corrections done. ${NC}"
	echo " # ${GREEN} All steps of Symlinks corrections done. # ${NC}"
	echo ""
	echo " # We copy new zshrc. and ZaemonSH config. #"
	rm "$ZAEM_ZSHRC_PATH" 2>/dev/null
	mv .zshrc-* "$ZAEM_ZSHRC_PATH"
	#cp -Rf .zsh $ZAEM_ZSH_PATH
	echo " ${GREEN} # New zshrc copied. # ${NC}"
	echo ""

	## CORRECT ZAEMONSH SYMLINKS BINARIES
	#####
	find $ZAEM_INIT_L_PATH/zsh/bin -maxdepth 1 -type l -exec rm {} \;
	#for sim in $(find $ZDOT/bin \! -name "*.zip" -type f -maxdepth 3 | grep OSX | grep -v "DS_Store") ; do
    	for sim in $(find $ZAEM_INIT_L_PATH/zsh/bin  -maxdepth 3 \! -name "*.zip" -type f  | grep -v "DS_Store" | grep -v '.pl' | grep -v "___OSX") ; do
		chown "$USER":"$USER" $sim
        chmod go-rwx $sim
        ln -s $sim $ZAEM_INIT_L_PATH/zsh/bin
	done
	#####

	## COPY VIM FILES
	echo " # We copy new vim configuration files. #"
	rm -Rf "${ZAEM_VIMRC_PATH}" 2>/dev/null
	cp -Rf .vim_runtime "$HOME"
	chown -R "$USER":"$USER" $HOME/.vim_runtime
    chmod -R go-rwx $HOME/.vim_runtime
    cp -Rf .vimrc "$HOME"
	chown "$USER":"$USER" $HOME/.vimrc
    chmod go-rwx $HOME/.vimrc
    echo " ${GREEN} # New vim configuration files copied. # ${NC}"
	echo ""

	## COPY NANO FILES
	echo " # We copy new nano folder. #"
	cp -Rf .nano "$HOME"
    chown -R "$USER":"$USER" $HOME/.nano
	chmod -R go-rwx $HOME/.nano
    echo " # We copy make new nanorc. #"
	echo /dev/null > "$ZAEM_NANORC_PATH"
	for i in $(find "${ZAEM_NANOFOLD_PATH}" -name \*.nanorc); do echo "include ${i}"; done > "${ZAEM_NANORC_PATH}"
	echo " ${GREEN} # New nanorc copied. # ${NC}"

	##
	echo ""
	rm -Rf "$(pwd)"
	IS_FIRSTSTART=1
    echo "${GREEN} ZAEMONSH installation done. ${NC}"
	echo ""
	echo "###########################################################"
}
#}}}

#----------------------------------------------------------------------------------------------------#
#                                               SCRIPT
#----------------------------------------------------------------------------------------------------#
emulate -L zsh
banner
if [[ "$OSTYPE" =~ ^(darwin)+ ]]; then
	ZAEMONSH_DarwinInstall
	command sleep 2
	#clear
    builtin cd
	builtin exec zsh
fi

if [[ "$OSTYPE" =~ ^(linux)+ ]]; then
	ZAEMONSH_LinuxInstall
	command sleep 2
	#clear
	builtin cd
   	builtin exec zsh
fi

### Modeline {{{
### vim:ft=zsh:foldmethod=marker
### vim:set ts=4:
### }}}   
