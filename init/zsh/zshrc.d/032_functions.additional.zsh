# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#                  $ZDOT/zshrc.d/032_functions.additional.zsh                     |
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
# File :  ${ZDOT}/zshrc.d/032_functions.additional.zsh
# sourced from  /etc/zshrc
# Version : 2.0.0
# Use this file to load extra additionnal functions that come with ZEAMONSH templates.
# Type "Z_Help_template_functions [foo]" for a description of each function [foo]
# In this file we autload all or a subset of the function in the directory
# called $ZDOT/zshrc.d/local-functions (or $ZDOT_TEMPLATE/local-functions).
# I've divided these into seven sets.  You can control which are loaded using
# seven controlling variables defined below, or fine-tune this using comments.
# 1 -
# The first set I am confident you won't want to live without, so they are
# autoloaded by default.  This is defined with LOAD_ADDITIONAL_FUNCTIONS_CONF='YES'
# 2 -
# The second set are additional functions that I like, but you might well find
# annoying.  These are not autoloaded by default, but you can load them by
# setting a flag.  (There are within this second set a few I have commented out,
# so you will have to also remove the comment (pound sign) to use these
# (these are ones I have but don't use).  LOAD_POSSIBLY_ANNOYING_FUNCTIONS='NO'
# If you put a file (even an empty one) called ~/.zsh/zlocalfxn in a user's home
# directory, the 'NO' setting will be over-ridden for that user.
# 3 -
# The third set are specific to X-ray crystallography and biophysics programs, so
# unless you use these programs, there is no reason to autoload them. (Most of
# these are programs that you can install with fink.   LOAD_CRYSTAL_FUNCTIONS='NO'
# If you have installed a crystallography program via fink, this will default
# to loading these functions after testing for the directory /sw/share/xtal.
# 4 -Grml additions.
# 5 -Syntax hightligthing
# 6 -Plugins extras
# 7 -Personnal
# These controlling variables can be changed to load the second and third
# set by changing 'NO' to 'YES' in each case:
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------
# 19/12/2019
# • Reduce to only one local-function ( admin-functions,dev-functions,gen-functions,
#   net-functions )

# 03/01/2020 :
# • Clean integrated plugins (syntaxhightliught , mouse , zshdb)


#---------------------------------------------------------------------------------
#                                     CHANGES
#---------------------------------------------------------------------------------
# 02/10/2017
# • Disable pluginextra
# 25/11/2017
# • Add local to all foreach variable.

# 19/12/2019
# • Problem with local functions corrected in condition wc < 1 to ..wc-l <= 1  .
# • Reduce to only one local-function ( admin-functions,dev-functions,gen-functions,
#   net-functions )

# 03/01/2020 :
# • Add mouse plugins

# 27/01/2020 :
# • Replace P_PLUGFCTDIR by P_ZDOTPLUGINSDIR.

#--------------------------------------------------------------------------------#

#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------
if [[ -o interactive ]]; then

        ########################################################
        #                                                      #
        #       For system-wide control, edit these:           #
        #                                                      #
                LOAD_ADDITIONAL_FUNCTIONS_CONF='YES'           #
        #                                                      #
                LOAD_POSSIBLY_ANNOYING_FUNCTIONS='NO'          #
        #                                                      #
                LOAD_CRYSTAL_FUNCTIONS='NO'                    #
        #                                                      #
                LOAD_GRML_ADDITION_FUNCTIONS='NO'              #
        #                                                      #
                LOAD_SYNTAX_HIGHTLIGTH_FUNCTION='YES'          #
        #                                                      #
                LOAD_MOUSE_FUNCTION='YES'                      #
        #                                                      #
                LOAD_PLUGINSEXTRA_FUNCTIONS='YES'              #
        #                                                      #
        ########################################################
      ##uncomment to debug
      # {{{ Loading status
          zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
      #}}}

      # {{{ Loading status
          zshrc_load_status () { echo "${YEL}  + Additional functions load:${GREY} $*${NC}"}
      #}}}


    if [[ $LOAD_ADDITIONAL_FUNCTIONS_CONF == 'YES' ]];then

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                              FUNCTIONS OPTONNAL                                 |
        # --------------------------------------------------------------------------------
        if [[ $LOAD_POSSIBLY_ANNOYING_FUNCTIONS == 'YES' || -f ~/.zsh/zlocalfxn ]];then
                if [[ -d $ZDOT_TEMPLATE/zshrc.d/local-functions/opt ]];then
                    FPATH=$ZDOT_TEMPLATE/zshrc.d/local-functions/opt:$FPATH
                fi

                if [[ -d $P_SYSFCTDIR/opt ]];then
                    FPATH=$P_SYSFCTDIR/opt:$FPATH
                fi
                ### An augmented man function to read zsh shell builtins and helpfiles.
                # man
                # screen

                ### Wrapper for sudo so when "sudo zsh" is invoked,
                # zsh will start root as a loging zsh shell to
                # avoid problems with environment clashes.
                # sudo

                #idiosyncratic ls variations
                 function lh { command ls -hltF "$@" | head }
                # ldot
                 alias ll='ls -l'
                FCTOPT=(man screen sudo ldot)

                if [[ $IS_MAC ]]; then
                    FCTOPT=(man screen sudo ldot checkmail bbown manmac startvnc)
                fi
                # --------------------------------
                #                                 \
                # ---------------------------------
                #          MOZCORE_DEBUG          |
                # ---------------------------------
                ##
                # uncomment for debugging
               zshrc_load_status  "Possibly annoying functions for zsh."
        fi  ## end ## [[ $LOAD_POSSIBLY_ANNOYING_FUNCTIONS == 'YES' ]]

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                              FUNCTIONS CRYSTOGRAPHY                             |
        # --------------------------------------------------------------------------------
         if [[ -f ~/.zsh/zxtalfxn || $LOAD_CRYSTAL_FUNCTIONS == 'YES' || -d $SWPREFIX/share/xtal ]]; then
                if [[ -d $ZDOT_TEMPLATE/zshrc.d/local-functions/xtal ]];then
                    FPATH=$ZDOT_TEMPLATE/zshrc.d/local-functions/xtal:$FPATH
                fi

                if [[ -d $P_SYSFCTDIR/xtal ]];then
                    FPATH=$P_SYSFCTDIR/xtal:$FPATH
                fi
                # Crystallography and biophysics-type functions
                #
                alias ccp4help="" ; unalias ccp4help
                alias sca2fobs='sca2mtz'
                alias cns="" ; unalias cns
                alias ono=""; unalias ono
            #####
            #/!\#
            #####
                FCTCRYSTO=( cns ono ccp4help ccp4_patches coot sca2mtz \
                           mos2fobs pymol overlay mapcover mapcoverdiff \
                           xdlmapman xdldataman getpdb canonicalize_pdb \
                           fix_namot cns_edit cns_web )
                  local rscr
                  foreach rscr in $FCTCRYSTO; do
                    autoload -U $rscr
                done
            #####
            #/!\#
            #####
                # Activate the environment.xtal script
                [[ ! -d ~/.zsh ]] && mkdir -p ~/.zsh
                touch ~/.zsh/use_xtal_env
                # --------------------------------
                #                                 \
                # ---------------------------------
                #          MOZCORE_DEBUG          |
                # ---------------------------------
                ##
                # uncomment for debugging
                zshrc_load_status "Crystographics function for zsh."
        fi  ## end ## [[ $LOAD_CRYSTAL_FUNCTIONS == 'YES' ]]

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                                  GRML ADDITION                                 |
        # --------------------------------------------------------------------------------
        if [[ $LOAD_GRML_ADDITION_FUNCTIONS == 'YES'  ||  -f ${HOME}/.zsh/grmladdi ]]; then
            if [[ $P_GRMLRCFIL ]]; then
                ## if GRML is dissabled.
                source $P_GRMLRCFIL
                echo zboob
                # --------------------------------
                #                                 \
                # ---------------------------------
                #          MOZCORE_DEBUG          |
                # ---------------------------------
                ##
                # uncomment for debugging
                zshrc_primary_load_status "GRML support for zsh."
            fi
        fi

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                          PLUGINSEXTRA ADDITION                                 |
        # --------------------------------------------------------------------------------
        #####
        #/!\# 02/10/2017 Disable Pluginextra Addition.
        #####
        if [[ $LOAD_PLUGINSEXTRA_FUNCTIONS == 'YES' && -f ${HOME}/.zsh/plugextraaddi ]]; then
        # if [[ $LOAD_PLUGINSEXTRA_FUNCTIONS == 'YES' ]]; then
            #--------------------------------
            #                                 \
            # ---------------------------------
            #         PLUGINSEXTRA              |
            # ---------------------------------
            if [[  -d "${P_ZDOTPLUGINSDIR}" ]]; then
                if ((  $( command ls -1  ${P_ZDOTPLUGINSDIR}/* | wc -l ) > 1 )); then
                    # Add the function directory to the head of $FPATH
                    for PLUGPATH in $(find $P_ZDOTPLUGINSDIR -name \*.zsh | grep -v 'disabled'); do
                        PLUGDIRPATH=${PLUGPATH%/*}
                        FPATH=${PLUGDIRPATH}:${FPATH}
                        export FPATH
                        typeset -U path manpath fpath
                        source ${PLUGPATH}
                    done
                    # --------------------------------
                    #                                 \
                    # ---------------------------------
                    #          MOZCORE_DEBUG          |
                    # ---------------------------------
                    ##
                    # uncomment for debugging
                    zshrc_load_status "Extras PlugIns support for zsh."
                fi
            fi
        fi  ## end ## [[ $LOAD_PLUGINSEXTRA_FUNCTIONS == 'YES' ]]

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                             SYNTAX HIGHLIGHT PLUGINS                            |
        # --------------------------------------------------------------------------------
        if [[ $LOAD_SYNTAX_HIGHTLIGTH_FUNCTION == 'YES'   ||  -f ${HOME}/.zsh/zshhightligth ]]; then
            ## Recreate symlinks
            rm -f ${P_SYSFCTDIR}/etc/zsh-syntax-highlighting.zsh
            ln -fs  ${P_SYSFCTDIR}/etc/plugs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  ${P_SYSFCTDIR}/etc/zsh-syntax-highlighting.zsh NE
            source ${P_SYSFCTDIR}/etc/zsh-syntax-highlighting.zsh
           #emulate zsh -c 'autoload -Uz ${ZDOT}/zshrc.d/local-functions/etc/plugs/zsh-syntax-highlighting.zsh'
            # --------------------------------
            #                                 \
            # ---------------------------------
            #          MOZCORE_DEBUG          |
            # ---------------------------------
            ##
            # uncomment for debugging
            zshrc_load_status "Syntax hightlight support for zsh."
        fi  ## end ## [[ $LOAD_SYNTAX_HIGHTLIGTH_FUNCTION == 'YES' ]]

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                                   MOUSE PLUGINS                                |
        # --------------------------------------------------------------------------------

        if [[ $LOAD_MOUSE_FUNCTION == 'YES'   ||  -f ${HOME}/.zsh/zshmouse ]]; then
            ## Recreate symlinks
            rm -f ${P_SYSFCTDIR}/etc/mouse.zsh 2>/dev/null
            ln -fs  ${P_SYSFCTDIR}/etc/plugs/mouse.zsh  ${P_SYSFCTDIR}/etc/mouse.zsh 2>/dev/null
            source ${P_SYSFCTDIR}/etc/mouse.zsh
           #emulate zsh -c 'autoload -Uz ${ZDOT}/zshrc.d/local-functions/etc/mouse.zsh'
            # --------------------------------
            #                                 \
            # ---------------------------------
            #          MOZCORE_DEBUG          |
            # ---------------------------------
            ##
            # uncomment for debugging
            zshrc_load_status "Mouse support for zsh."
        fi  ## end ## [[ $LOAD_SYNTAX_HIGHTLIGTH_FUNCTION == 'YES' ]]

        
        ###############################################################################
        ###############################################################################
        #
        # This alters the default behavior of the  completion
        # functions.   If  set  to  on, words which have more
        # than one possible completion cause the  matches  to
        # be  listed immediately instead of ringing the bell.
        set show-all-if-ambiguous on
        # needed here so it works the first time (why?)

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
        #          MOZCORE_DEBUG          |
        # ---------------------------------
        # uncomment for debugging
        zshrc_primary_load_status "Additional functions set."
    fi  ## end ## [[ $LOAD_ADDITIONAL_FUNCTIONS_CONF == 'YES' ]]
fi ## end ## [[ -o interactive ]]
###############################################################################
##############################################################################
