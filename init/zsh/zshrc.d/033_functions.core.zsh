# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#                     $ZDOT/zshrc.d/033_functions.core.zsh                        |
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
# File :  ${ZDOT}/zshrc.d/033_functions.core.zsh
# sourced from  /etc/zshrc
# Version : 2.0.0
# This file load the core extra functions that come ZEAMONSH templates.
# This file also is where the prompt functions, including the customized
# prompts supplied with zsh and supplied with zsh-templates, are loaded.
# (See last part of file).
# Type "Z_Help_template_functions [foo]" for a description of each function [foo]
# In this file we autload all or a subset of the function in the directory
# called $ZDOT/zshrc.d/local-functions (or $ZDOT_TEMPLATE/local-functions).

# I've divided these into four sets.  You can control which are loaded using
# four controlling variables defined below, or fine-tune this using comments.

# The set I am confident you won't want to live without, so they are
# autoloaded by default.  This is defined with LOAD_CORE_FUNCTIONS_CONF='YES'
# These controlling variables can be changed to load the second and third
# set by changing 'NO' to 'YES' in each case:
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------
# 27021017 :
# Problem with prompt in function (prompt_ResetAll_setup prompt_bz_setup
# prompt_kerbaugh_setup prompt_pure_setup prompt_simple_setup) folder in linux.

#---------------------------------------------------------------------------------
#                                     CHANGES
#---------------------------------------------------------------------------------

# 28/09/2017:
# - Reorder function :
#     • Move "Z_UpdateOSX" function between (033)FCTLIST_DARWCORE to (034)FCTLIST_DARWSU
#     • Move "open" "edit" function between (033)FCTLIST_DARWCORE to (034)FCTLIST_DARWDAI
#     • Move "quit" "quit_app" between (033)FCTLIST_DARWCORE to (034)FCTLIST_DARWDAI
#     • Move "Z_Sudo_open" "sudo_do" between (033)FCTLIST_DARWCORE to (034)FCTLIST_DARWSU
#     • Remove "Z_CoreConfigMenu" from (033)FCTLIST_UNICORE
# 07/10/2017 :
# • Order functions in right functions list
# 11/11/2017 :
# • Change function list naming
# 30/07/2019 :
# • Add additionnals functions functions.
# 04/08/2019 :
# • Add additionnals functions functions.
# 23/08/2019 :
# • Add Z_OsxVersTest on core darwin .
# 17/02/2020 :
# • Add Z_Zenity_interface on $FCTLIST_ZCOR_LINU
# • Add Z_CompFctList on $FCTLIST_ZCOR_UNI
# 2020-06-20 :
# • Move  Z_Switch_prompt_ascli and Z_Configure_zaemonsh_templates_ascli  to universal category
# 2020-08-15 :
# • Add Z_CmdLineFUpdate Z_Correctdate Z_FunctionAdd Z_FunctionDel Z_FunctionPluginsExtraLoop to FCTLIST_ZCOR_UNI

#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------
if [[ -o interactive ]]; then

        #########################################################
        #                                                       #
        #      For ZeamonSH Core system control, edit these:    #
        #                                                       #
                    LOAD_CORE_FUNCTIONS_CONF='YES'              #
        #                                                       #
                    LOAD_CORE_LINUX_FUNCTIONS='YES'             #
        #                                                       #
                    LOAD_CORE_DARWIN_FUNCTIONS='YES'            #
        #                                                       #
                    LOAD_CORE_UNIVERSAL_FUNCTIONS='YES'         #
        #                                                       #
        #                                                       #
        #########################################################


    if [[ $LOAD_CORE_FUNCTIONS_CONF == 'YES' ]]; then
        if [[ -d $ZDOT_TEMPLATE/zshrc.d/local-functions/core ]];then
            FPATH=$ZDOT_TEMPLATE/zshrc.d/local-functions/core:$FPATH
        fi

        if [[ -d $ZDOT/zshrc.d/local-functions/core ]];then
            FPATH=$ZDOT/zshrc.d/local-functions/core:$FPATH
        fi
    fi
      ##uncomment to debug
      # {{{ Loading status
          zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
      #}}}

      # {{{ Loading status
          zshrc_load_status () { echo "${YEL}  + Core functions load:${GREY} $*${NC}"}
      #}}}

    ###############################################################################
    ###############################################################################
    # ------------------------------------------------------------------------------
    #                                                                               \
    # --------------------------------------------------------------------------------
    #                            FUNCTIONS CORE : LINUX                               |
    # --------------------------------------------------------------------------------
    if [[ $LOAD_CORE_LINUX_FUNCTIONS == 'YES' ]]  &&  [[ $IS_LINUX ]]; then
        # This is used to prompt a new user to configure the templates
        #####
        #/!\#
        #####

            ## Don't remove that anchor !
            #______##______#
            FCTLIST_ZCOR_LINU=( Z_Open \
                                Z_Zenity_interface Z_CleanOSXSHIT Z_Zenity_host_setup \
                                Z_Switch_prompt_zenity Z_Zenity_user_setup     \
                                Z_Configure_zaemonsh_templates_zenity  )
            #______###______#

            ## Don't remove that anchor !
            local fctcorl
            foreach fctcorl in $FCTLIST_ZCOR_LINU; do
                autoload -U $fctcorl
                # autoload -U $fctcorl.zwc
                # echo "${GREY}+ Core functions conf load:${NC}cleankikGREEN}Core darwin functions for ZeamonSH.${NC}"
            done
            unset fctcorl
            zshrc_load_status "Linux for ZeamonSH."
        #####
        #/!\#
        #####
    fi ## end ## [[ -o interactive ]]

    ###############################################################################
    ###############################################################################
    # ------------------------------------------------------------------------------
    #                                                                               \
    # --------------------------------------------------------------------------------
    #                             FUNCTIONS CORE : DARWIN                             |
    # --------------------------------------------------------------------------------
    if [[ $LOAD_CORE_DARWIN_FUNCTIONS == 'YES' ]]  &&  [[ $IS_MAC ]]; then
                ## Don't remove that anchor !
        #______##______#
        FCTLIST_ZCOR_DARW=( prompt_setup_gister prompt_magicmace_setup \
                            Z_OsxVersTest prompt_eriner_setup prompt_asyd_setup                    \
                            Z_Open Z_Edit Z_Selectfile Z_Gui_password Z_Customize_x11              \
                            Z_User_setup Z_User_setup_ascli Z_Keep Z_Testsplit                     \
                            Z_Configure_zaemonsh_templates Z_Pashua_run Z_My_mac_applications      \
                            Z_Customize_x11_10.5 Z_Configure_zaemonsh_templates_asgui              \
                            Z_Configure_zaemonsh_templates_pashua                                  \
                            Z_Customize_x11_10.4 Z_Customize_x11_gui Z_Customize_x11_gui_10.4      \
                            Z_Customize_x11_gui_10.5 Z_Customize_xquartz_gui Z_Enable_faster_open  \
                            Z_Guidirs_pashua Z_Host_setup Z_Host_setup_cli Z_My_prefs_edit         \
                            Z_Osa_choose_list Z_Osa_direc_browser Z_Osa_display_dialog             \
                            Z_Osa_file_browser Z_Switch_prompt zulu  )
        #______###_____#
        ## Don't remove that anchor !
            local fctcord
            foreach fctcord in $FCTLIST_ZCOR_DARW; do
                autoload -U $fctcord
                # autoload -U $fctcord.zwc
            done
            unset fctcord
            zshrc_load_status "Darwin for ZeamonSH."


        ################################################
        # two alternatives for gdirs:
        if [[ -z $GUIDIRS_PASHUA ]];then
            GUIDIRS_PASHUA='yes'
        fi
        # GUIDIRS_PASHUA='no'
        if [[ $GUIDIRS_PASHUA == 'yes' ]];then
            autoload Z_Guidirs_pashua
            function gdirs {
                typeset -U dirs_shared
                dirstack $1 > /dev/null
                Z_Guidirs_pashua  2> /dev/null
            }
            alias gdirs="typeset -U dirs_shared; dirstack > /dev/null ; Z_Guidirs_pashua"
        else
            autoload _Z_Guidirs
            function gdirs {
                typeset -U dirs_shared
                dirstack $1 > /dev/null
                _Z_Guidirs 2> /dev/null
            }
            alias gdirs="typeset -U dirs_shared; dirstack > /dev/null ; _Z_Guidirs"
        fi
        typeset -U dirs_shared
        # This activates the settitle, settab functions that will persist
        # even if you change to a customizable prompt.
        # If you don't want to use settab and settitle, then issue the command
        # "touch ~/.zsh/notitletabs" .  Note that the "simple" prompt will over-ride
        # this setting.
        if [[ ! -f ~/.zsh/notitletabs ]]; then
            # echo "${BRED}"
            autoload -U Z_Set_title_tab; Z_Set_title_tab
        fi
        ######################
        #####
        #/!\# Z_Notes UpdateCommandlinefu_v1.sh \
    fi

    ###############################################################################
    ###############################################################################
    # ------------------------------------------------------------------------------
    #                                                                               \
    # --------------------------------------------------------------------------------
    #                          FUNCTIONS CORE:UNIVERSAL                              |
    # --------------------------------------------------------------------------------
    if [[ $LOAD_CORE_UNIVERSAL_FUNCTIONS == 'YES' ]]; then
        #/!\### 27021017 : Problem with prompt in function (prompt_ResetAll_setup prompt_kerbaugh_setup prompt_pure_setup prompt_simple_setup) folder in linux.
        ## Don't remove that anchor !
        #______##______#
        FCTLIST_ZCOR_UNI=( Z_CmdLineFUpdate Z_Correctdate Z_FunctionAdd Z_FunctionDel \
                           Z_FunctionPluginsExtraLoop Z_Configure_zaemonsh_templates_ascli        \
                           Z_Switch_prompt_ascli Z_CompFctList Z_Session Z_OptList Z_CleanOSXSHIT \
                           Z_CompletionWhereis prompt_dotphiles_setup prompt_nicoulaj_setup       \
                           prompt_steeef_setup prompt_sorin_setup                                 \
                           Z_SkelF Z_SkelC Z_Update Z_Debug Z_Restart                             \
                           Z_Reporter Z_Notes Z_Note Z_Notes-problems Z_Notes-tag-helper          \
                           Z_Backup Z_Sudo_fct prompt_bz_setup Z_Whatsnew Z_Agenda                \
                           Z_Addagenda Z_Banner Z_FunctionBySubcat Z_AliasAllList                 \
                           Z_CorrectSymlinksFunction Z_FunctionEdit Z_CompletionEdit              \
                           Z_FunctionWhereis Z_Grml Z_Search Z_Settings Z_SyntaxLight             \
                           Z_FunctionUtil Z_Addagenda Z_How-many-commands Z_Inpath                \
                           Z_Showfile Z_Help_template_functions help_zsh_templates                \
                           host_user_completion_settings prompt_ResetAll_setup                    \
                           prompt_kerbaugh_setup prompt_pure_setup prompt_simple_setup            \
                           Z_Which Z_Caches_cleaner Z_AliasWhereis Z_colors )
        #______###______#
        ## Don't remove that anchor !
            local fctcoru
            foreach fctcoru in $FCTLIST_ZCOR_UNI; do
                autoload -U $fctcoru
                # autoload -U $fctcoru.zwc
            done
        unset fctcoru
        #####
        #/!\#
        #####
        zshrc_load_status "Universal for ZeamonSH."
    fi

    ###############################################################################
    ###############################################################################
    # ------------------------------------------------------------------------------
    #                                                                               \
    # --------------------------------------------------------------------------------
    #                                       PROMPT                                   |
    # --------------------------------------------------------------------------------
    #-----------------------------------------------------------
    # Choose default shell prompt AND Update terminal Titlebar and Tab
    #-----------------------------------------------------------
    # Load the default zsh prompt switching command-line interface
    # autoload -U promptinit; promptinit
    autoload -U promptinit; promptinit -u
    # autoload -U promptinit; promptinit 1>/dev/null 2>/dev/null


    # To customize the prompt, copy $ZDOT_TEMPLATE/zshrc.d/prompt to
    # ~/.zsh/zshprompt and modify.  The function Z_Switch_prompt automates
    # this procedure.
    if [[ -f ~/.zsh/zshprompt ]];then
       source ~/.zsh/zshprompt
    elif [[ -f $ZDOT/zshrc.d/prompt ]];then
       source $ZDOT/zshrc.d/prompt
    else
       source $ZDOT_TEMPLATE/zshrc.d/prompt
    fi

    ########################################################
    ##### To have acess to compgen command on zsh.
    autoload -U bashcompinit

    ########################################################
    # This alters the default behavior of the  completion
    # functions.   If  set  to  on, words which have more
    # than one possible completion cause the  matches  to
    # be  listed immediately instead of ringing the bell.

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
    # --------------------------------
    #                                 \
    # ---------------------------------
    #         ZEAMONSHCORE_DEBUG       |
    # ---------------------------------
    # uncomment for debugging
    zshrc_primary_load_status "Core functions set."
fi ## end ## [[ -o interactive ]]
