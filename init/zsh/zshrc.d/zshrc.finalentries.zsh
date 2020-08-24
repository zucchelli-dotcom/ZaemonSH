# -----------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#                       $ZDOT/zshrc.d/zsh.finalentries.zsh                        |
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
#  File:  $ZDOT/zshrc.d/zsh.finalentries.zsh
#  sourced from /etc/zshrc
#  Version: 2.0.0
#  This is the last file to get sourced in $ZDOT/zshrc.d
#  Launch graphical configuration of ZeamonSH if it'sn not already achieved.
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------
# 01/09/19
#  • If the install process is start with an another user.The Gui install is unvailable
#    terminal.

#---------------------------------------------------------------------------------
#                                     CHANGES
#---------------------------------------------------------------------------------
# 17/07/19
#  • Modify function presentation.
#  • Add cli installation option
# 27/01/2020 :
#  •  If user don't want to followed zaemon install add -f ~/.zsh/noinstalldisturb and Add NOTNOW options to install to bypass loop each time you reopen a new terminal ,

#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------
###################################################################################
# {{{ Loading status
    zshrc_primary_load_status() { echo "\e[32m***************************$(date "+%H:%M:%S")******************************\e[0m"  }
#}}}

# {{{ Loading status
    zshrc_load_status () { ''}
#}}}

###################################################################################
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                           AUTOCOMPLETION FUNCTIONS                             |
# --------------------------------------------------------------------------------
autoload -U compinit && compinit
# avoid repeats in the paths
typeset -U path manpath fpath

###############################################################################
###############################################################################
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                          PROMPT NEW USER TO CONFIGURE:                         |
# --------------------------------------------------------------------------------

##if [[ -o interactive  &&  ! -f ~/.zsh/configure_zsh_templates  &&  "$OSTYPE" =~ ^(darwin)+  &&  -z $SSH_CONNECTION ]]; then
if [[ -o interactive  &&  ! -f ~/.zsh/configure_zsh_templates  && ! -f ~/.zsh/noinstalldisturb &&  $IS_MAC  && -z $SSH_CONNECTION ]]; then
		# dialogue_text=( To configure the zsh templates, you can choose to use a series of
		# 		small dialog boxes like this one \(better for smaller displays\) or a single
		# 		larger configuration pane \(more suited to larger displays\). You will be asked
		# 		a series of questions, and can choose to change things or leave them as they are.
		# 		You can undo any changes later by issuing the command: Z_Configure_zaemonsh_templates_asgui )
        sleep 2
        wait
        clear
        echo "${NC}"
        echo -e "${CONDCOLOR}${LINE}"
        echo -e '                      ______                                   _____ __      '
        echo -e '                     /___   / ____  ___  ____ ___  ____  _____/ ___// /__   '
        echo -e '                       /   / / __ `/ _ \/ __ `__ \/ __ \/ __  \__ \/ __  / '
        echo -e '                      /   /_/ /_/ /  __/ / / / / / /_/ / / / /__/ / / / / '
        echo -e "                     /______\__,_/\___/_/ /_/ /_/\____/_/ /_/____/_/ /_/ ${NC}"
        echo -e "                      ${RED}This is ZAEMONSH-${YEL}${ZAEMONBASENB}v${ZAEMONSHVERSION}${RED} on ZSH ${YEL}${ZSH_VERSION%.*}${RED} - DISPLAY on ${YEL}$(print -rP "%23<..<$DISPLAY")"
        echo "${NC}"
        echo -e "${CONDCOLOR}${LINE}"
        echo ""
        echo "________________________________________________________________________________________"
        echo ""
        echo "${YEL}Would you like to continue configure ZeamonSH with the CLI or with a gui ?${NC}"
        echo "________________________________________________________________________________________"
        echo ""
            select reponse in NOTNOW CLI GUI ; do  ##  select reponse in Infos Load Unload Move Erase Edit Rename Back; do
		    case $reponse in
		        NOTNOW)
                    print "${GREEN}Leaving this setting unchanged.${NC}"
                    sleep 1
                    wait
                    clear
                    [[ ! $HOME/.zsh ]] && mkdir $HOME/.zsh 
                    touch .zsh/noinstalldisturb
                    source $HOME/.zshrc && return 0
                    ;;               
                CLI)
                    clear
                    echo "________________________________________________________________________________________"
                    echo "${YEL}Continue the install process now ?${NC}"
                    echo "________________________________________________________________________________________"
                    select answer in "Never" "Not Now" "Yes please"; do
                        echo $answer
                        if [[ "$answer" == "Never"  ]]; then
                                mkdir -p ~/.zsh
                                touch ~/.zsh/configure_zsh_templates
                                print "Issue the command"
                                print "\e[1m Z_Configure_zaemonsh_templates \e[0m "
                                print "if you decide to give this a try."
                                sleep 2
                                clear
                                source $HOME/.zshrc
                        elif [[ "$answer" == "Not now"  ]]; then
                                print "${GREEN}Leaving this setting unchanged.${NC}"
                                sleep 1
                                wait
                                clear
                                source $HOME/.zshrc
                        elif [[ "$answer" == "Yes please"  ]]; then
                                autoload -U Z_Configure_zaemonsh_templates_ascli
                                Z_Configure_zaemonsh_templates_ascli
                                return 1
                        else
                                 return 1
                        fi
                    break
                    done
                    break

                    ;;
		        GUI)
                    clear
                    if [[ $IS_SU ]] ||  [[ $SSH_CONNECTION ]]; then
                            echo "${WB}Sorry you can't run GUI install. Use CLI one !${NC}"
                    else

                        dialogue_text=(" Please take a moment to customize your ZSH environment on OS X ")
                        answer1=$(Z_Osa_display_dialog "Never" "Not now" "Yes please")
                        if [[ "$answer1" == "Never"  ]]; then
                            mkdir -p ~/.zsh
                            touch ~/.zsh/configure_zsh_templates
                            print "Issue the command"
                            print "\e[1m Z_Configure_zaemonsh_templates \e[0m "
                            print "if you decide to give this a try."
                        elif [[ "$answer1" == "Not now"  ]]; then
                            print "${RED}Leaving this setting unchanged.${NC}"
                            sleep 1
                            wait
                            clear
                            return 1
                        else
                            if [[ $IS_MAC  ]]; then
                                autoload -U Z_Configure_zaemonsh_templates
                                 Z_Configure_zaemonsh_templates
                                 [[ ! FINDER_RUN ]] && quit Finder && return 0
                            fi
                        fi
                    fi
                  ;;
		        *)
                    return 1
		          ;;

		    esac
	    	done

fi

###################################################################
if [[ -o interactive  &&  ! -f ~/.zsh/configure_zsh_templates  && ! -f ~/.zsh/noinstalldisturb &&  $IS_LINUX && -z $SSH_CONNECTION ]]; then
# if [[ -o interactive && ! -f ~/.zsh/configure_zsh_templates && $IS_LINUX ]];  then
		function zenity_display_dialog {
		#  Display times out according to the variable $timeout in seconds (defaults to 15 sec).
		    if [[ -z $timout ]]; then
		        timout='15'
		    fi

		    if [[ -z $dialogue_text ]]; then
		        dialogue_text=( Choose a button: )
		    fi
			zenity --title=M0ZSH --text=M0ZSH --question --text=$dialogue_text  --extra-button="Never" --extra-button="Not now" --extra-button="Yes please" --switch 2>/dev/null
		}
		# timout='45'

        sleep 2
         wait
         clear
         echo "${NC}________________________________________________________________________________________"
         echo "${YEL}Would you like to continue configure ZeamonSH with the CLI or with a gui ?${NC}"
         echo "________________________________________________________________________________________"
             select reponse in NOTNOW CLI GUI; do
                 case $reponse in
                  NOTNOW)
                     print "${GREEN}Leaving this setting unchanged.${NC}"
                     sleep 1
                     wait
                     clear
                     [[ ! $HOME/.zsh ]] && mkdir $HOME/.zsh 
                     touch .zsh/noinstalldisturb                                                               
                     source $HOME/.zshrc && return 0
                     ;;                  
                  CLI)
                     clear
                     echo "${NC}________________________________________________________________________________________"
                     echo "${YEL}Please take a moment to customize your ZSH environment on Linux ?${NC}"
                     echo "________________________________________________________________________________________"
                     select answer in "Never" "Not Now" "Yes please"; do
                         echo $answer
                         if [[ "$answer" == "Never"  ]]; then
                                 mkdir -p ~/.zsh
                                 touch ~/.zsh/configure_zsh_templates
                                 print "Issue the command"
                                 print "\e[1m Z_Configure_zaemonsh_templates_zenity \e[0m "
                                 print "if you decide to give this a try."
                                 sleep 2
                                 clear
                                 source $HOME/.zshrc
                         elif [[ "$answer" == "Not now"  ]]; then
                                 print "${GREEN}Leaving this setting unchanged.${NC}"
                                 sleep 1
                                 wait
                                 clear
                                 source $HOME/.zshrc
                         elif [[ "$answer" == "Yes please"  ]]; then
                                 autoload -U Z_Configure_zaemonsh_templates_ascli
                                 Z_Configure_zaemonsh_templates_ascli
                                 return 1
                         else
                                  return 1
                         fi
                     break
                     done
                     break
                     ;;
                 GUI)
                    clear
                    if [[ $IS_SU ]] || [[ $SSH_CONNECTION ]]; then
                            echo "${WB}Sorry you can't run GUI install. Use CLI one !${NC}"
                    else

                        dialogue_text="Please take a moment to customize your ZSH environment on Linux ?"
                        ButtonYes="Yes please"
                        ButtonNever="Never"
                        ButtonNotNow="Not now"
                        #zenity --title=M0ZSH --text=M0ZSH --question --text=$dialogue_text --extra-button="Yes please" --extra-button="Never" --extra-button="Not now" --switch 2>/dev/null

                        # zenity_display_dialog

                        resu=$(zenity_display_dialog | tail -n1)
                        echo $resu
                        if [[ "$resu" ==  "Never" ]]; then
                            #echo "You choose Never"
                            mkdir -p ~/.zsh
                            touch ~/.zsh/configure_zsh_templates
                            print "Issue the command"
                            print "\e[1m configure_zsh_linuxtemplates \e[0m "
                            print "if you decide to give this a try :"
                            autoload -U configure_zsh_linuxtemplates

                        elif [[ "$resu" ==  "Not now" ]]; then
                            #echo "Not now"
                            print "Leaving this setting unchanged."
                            #autoload -U configure_zsh_linuxtemplates
                        else
                            echo "You choose Yes please"
                            ##autoload -U configure_zsh_linuxtemplates
                            ##configure_zsh_linuxtemplates
                            ## clear && exec zsh
                            touch ~/.zsh/configure_zsh_templates
                            autoload -U Z_Configure_zaemonsh_templates_zenity
                            Z_Configure_zaemonsh_templates_zenity
                            clear && exec zsh
                            # mkdir -p ~/.zsh
                            # touch ~/.zsh/configure_zsh_templates

                            # clear && zsh -c "$functions[configure_zsh_linuxtemplates]" "configure_zsh_linuxtemplates"
                            #clear && restart
                        fi
                    fi
                    ;;
                    *)
                        return 0;
                    ;;

                esac
            done
# else
#     [[ $IS_ADMIN ]] && [[ $IS_SU ]] && cd
fi
 #
