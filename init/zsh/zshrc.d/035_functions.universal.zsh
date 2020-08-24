# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#                   $ZDOT/zshrc.d/035_functions.universal.zsh                     |
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
# File : $ZDOT/zshrc.d/035_functions.universal.zsh
# sourced from  /etc/zshrc
# Version : 2.0.0
# Use this file to load universal platform functions that come with ZEAMONSH templates.
# Type "Z_Help_template_functions [foo]" for a description of each function [foo]
# In this file we autload all or a subset of the function in the directory
# called $ZDOT/zshrc.d/local-functions (or $ZDOT_TEMPLATE/local-functions).
# I've divided these into three sets.  You can control which are loaded using
# three controlling variables defined below, or fine-tune this using comments.

# The set I am confident you won't want to live without, so they are
# autoloaded by default.  This is defined with LOAD_UNIVERSAL_FUNCTIONS='YES'

# These controlling variables can be changed to load the second and third
# set by changing 'NO' to 'YES' in each case:
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                     TODO
#---------------------------------------------------------------------------------
# 11/11/2017 :


#---------------------------------------------------------------------------------
#                                    CHANGES
#---------------------------------------------------------------------------------
# 11/11/2017 :
# • Add differrent condition (between linux and darwin) to access on sudoneed function.
# • Change function list naming
# 25/11/2017
# • Add autoload function for each list of functions.
# 30/07/2019 :
# • Add functions : change-extension, clipcat  .
# 2020-06-28 :
# • Add functions : ff fs DirCmp fstr to FCTLIST_DAI_UNI 
# 2020-06-30 :
# • Add functions : tar-ssh-from ssh_key_manager getcertnames ssl-cert-create to FCTLIST_ADM_UNI
# • Add functions : targz to FCTLIST_DAI_UNI
# 2020-07-01 :
# • Add functions : phpserver virt-ip to FCTLIST_ADM_UNI
# 2020-08-18 :
# • Move compildis compilena between  FCTLIST_ADM_UNI to FCTLIST_SU_UNI

#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------
if [[ -o interactive ]]; then
      ##uncomment to debug
      # {{{ Loading status
          zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
      #}}}

      # {{{ Loading status
          zshrc_load_status () { echo "${YEL}  + Universal aliases load:${GREY} $*${NC}"}
      #}}}


        ########################################################
        #                                                      #
        #       For system-wide control, edit these:           #
        #                                                      #
                    LOAD_UNIVERSAL_FUNCTIONS='YES'             #
        #                                                      #
        #                                                      #
        ########################################################

    if [[ $LOAD_UNIVERSAL_FUNCTIONS == YES ]]; then
        if [[ -d $ZDOT_TEMPLATE/zshrc.d/local-functions/universal ]];then
            FPATH=$ZDOT_TEMPLATE/zshrc.d/local-functions/universal:$FPATH
            #####
            #/!\#   else
            #####  echo ERROR :
        fi

        if [[ -d $P_SYSFCTDIR/universal ]];then
            FPATH=$P_SYSFCTDIR/universal:$FPATH
        fi

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                              ADMIN UNIVERSAL FUNCTIONS                          |
        # --------------------------------------------------------------------------------
        if [[ $IS_ROOT ]] || [[ $IS_ADMIN ]] || [[ -n $(/usr/bin/id $USER 2>/dev/null | grep -w wheel) ]]; then
                ## Don't remove that anchor !
                #______##______#
                FCTLIST_SU_UNI=( compildis compilen amklocatedb flags unflags sudogvim sudovi sudovim )
                #______###______#
                ## Don't remove that anchor !
                local fctunis
                foreach fctunis in $FCTLIST_SU_UNI; do
                    autoload -U $fctunis
                done
                unset fctunis
        zshrc_load_status "Administrator functions"
	fi

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                        ADMINISTRATION UNIVERSAL FUNCTIONS                       |
        # --------------------------------------------------------------------------------

        ## Don't remove that anchor !
        #______##______#
        FCTLIST_ADM_UNI=( short_pwd lcheck getcertnames ssl-cert-create                 \
                          permissions change-extension buf dbackup docron verifycron    \
                          diskhogs diskspace fquota findsuid cpu_infos ii menusage      \
                          zoneinfo  unpacker isroot validfloat                          \
                          my_ip getstats screenn my_ps pgep pidof renicename  ask       \
                          hgrep repeato title-tab findman formatdir locate_pat validint )
        #______###______#
        ## Don't remove that anchor !
        local fctunia
        foreach fctunia in $FCTLIST_ADM_UNI; do
            autoload -U $fctunia
        done
        unset fctunia
        zshrc_load_status "Administration functions."

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                           DAILY-USE UNIVERSAL FUNCTIONS                         |
        # --------------------------------------------------------------------------------
        ## Don't remove that anchor !
        #______##______#
        FCTLIST_DAI_UNI=( clock targz tmuxmulti ff fs DirCmp fstr             \
                          escape unidecode kalimetre ogrep eml emk            \
                          clipcat lock archall extract gunall roll unarchall  \
                          archivedir cd_  dirdump dirstack ldirs cdmk         \
                          findus dotgrep envgrep lgrep renice_grep sgrep      \
                          txtgrep run-help killit killps stoppedjobs          \
                          locwd manzsh XPath rmall dusize                     \
                          swap cuttail e lowercase  mmake_transparent whichre )
        #______###______#
        ## Don't remove that anchor !
        local fctunida
        foreach fctunida in $FCTLIST_DAI_UNI; do
            autoload -U $fctunida
        done
        unset fctunida
        zshrc_load_status "Dailyuse functions."

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                           DEVELOPMENT UNIVERSAL FUNCTIONS                       |
        # --------------------------------------------------------------------------------
        ## Don't remove that anchor !
        #______##______#
        FCTLIST_DEV_UNI=( CDataType decToBin decToHex hexToBinary \
                          arduinoToAVRPinNames avrPortFunctionMultiplexing \
                          apache gitx hex jsonval ppath tidyxml )
        #______###______#
        ## Don't remove that anchor !
        local fctunide
        foreach fctunide in $FCTLIST_DEV_UNI; do
            autoload -U $fctunide
        done
        unset fctunide
	zshrc_load_status "Development functions"

	    ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                               MEDIA UNIVERSAL FUNCTIONS                         |
        # --------------------------------------------------------------------------------
        ## Don't remove that anchor !
        #______##______#
        FCTLIST_MED_UNI=( joinpdf )
        #______###______#
        ## Don't remove that anchor !
        local fctunim
        foreach fctunim in $FCTLIST_MED_UNI; do
            autoload -U $fctunim
        done
        unset fctunim
	zshrc_load_status "Media functions"

        ###############################################################################
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                               NETWORK UNIVERSAL FUNCTIONS                       |
        # --------------------------------------------------------------------------------
        ## Don't remove that anchor !
        #______##______#
        

        FCTLIST_NET_UNI=( phpserver                                           \
                          addvirtual webaccess weberrors remotebackup         \
                          ftpsyncdown ftpsyncup sftpsync ssync xferlog        \
                          virt-ip tar-ssh-from ssh_key_manager rcommand       \
                          magento httpcompression get-ict                     \
                          curlito googetimages ggl google goomp               \
                          gosec gsearch image_crawler prettyping headers rfc  \
                          uopen up checkexternal checklinks getlinks webspell )
        #______###______#
        ## Don't remove that anchor !
        local fctunin
        foreach fctunin in $FCTLIST_NET_UNI; do
            autoload -U $fctunin
        done
        unset fctunin
        zshrc_load_status "Network functions"


        # ---------------------------------------------------------------------
        # --------------------------------
        #                                 \
        # ---------------------------------
        #          MOZCORE_DEBUG          |
        # ---------------------------------
        # uncomment for debugging
        zshrc_primary_load_status "Universal functions set."
    fi   ## end ## [[ $LOAD_ESSENTIAL_FUNCTIONS == 'YES' ]]


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
###############################################################################
