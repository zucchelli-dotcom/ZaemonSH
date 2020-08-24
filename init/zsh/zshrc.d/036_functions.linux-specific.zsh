# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |   
#                                - ZAEMONSH -                                     |
#                       036_functions.linux-specific.zsh                          |
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
# File : $ZDOT/zshrc.d/036_functions.linux-specific.zsh
# sourced from  /etc/zshrc
# Version : 1.0.0
# Linux functions definitions.
# Use this file to load extras Linux functions that come with ZEAMONSH templates.
# Type "Z_Help_template_functions [foo]" for a description of each function [foo]
## In this file we autload all or a subset of the function in the directory
# called $ZDOT/zshrc.d/local-functions (or $ZDOT_TEMPLATE/local-functions).
## This set I am confident you won't want to live without, so it is
# autoloaded by default.  This is defined with LOAD_LINUX_FUNCTIONS='YES'    
## That controlling variable can be changed by changing 'NO' to 'YES':
#---------------------------------------------------------------------------------
#                                     TODO
#---------------------------------------------------------------------------------
# 11/11/2017 :
# • Test functions and sudoneed different condition on darwin and linux.

#---------------------------------------------------------------------------------
#                                    CHANGES
#---------------------------------------------------------------------------------
# 08/11/2017 :
# • Add linux list of function by categories (administration, dailyuse, developpement, media, network, sudoneed )
#   with the same momenclature as darwin one.
# 11/11/2017 :
# • Add sudoneed function list for linux.
# • Change function list naming 
# 25/11/2017
# • Add autoload function for each list of unctions.

#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------
if [[ -o interactive ]]; then
      ##uncomment to debug
      # {{{ Loading status
          zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
      #}}}

      # {{{ Loading status
          zshrc_load_status () { echo "${YEL}  + Linux aliases load:${GREY} $*${NC}"}
      #}}}    
        ########################################################
        #                                                      #
        #           For linux control, edit these:             #
        #                                                      #
                      LOAD_LINUX_FUNCTIONS='YES'               #
        #                                                      # 
        ######################################################## 
                  
    if [[ $LOAD_LINUX_FUNCTIONS == 'YES' ]]  &&  [[ "$OSTYPE" =~ ^(linux)+ ]]; then
        if [[ -d $ZDOT_TEMPLATE/zshrc.d/local-functions/linux ]];then
            FPATH=$ZDOT_TEMPLATE/zshrc.d/local-functions/linux:$FPATH
        #####
        #/!\#   else 
        #####  echo ERROR : 
        fi

        if [[ -d $P_SYSFCTDIR/linux ]];then
            FPATH=$P_SYSFCTDIR/linux:$FPATH
        fi

        ###############################################################################    
        ###############################################################################            
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                              LINUX ADMIN FUNCTIONS                              |   
        # --------------------------------------------------------------------------------  
        if [[ $IS_ROOT ]] || [[ $IS_ADMIN ]]; then
            ## Don't remove that anchor !
            #______##______#
            FCTLIST_SU_LINU=( )
            #______###______#
            ## Don't remove that anchor !
            fctlinusz () {
            local fctlinus  
            foreach fctlinus in $FCTLIST_SU_LINU; do 
                autoload -U $fctlinus
            done    
            }
            fctlinusz
        fi
        
        ###############################################################################    
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                             LINUX ADMINISTRATION FUNCTIONS                      |   
        # --------------------------------------------------------------------------------
        ## Don't remove that anchor !
        #______##______#
        FCTLIST_ADM_LINU=( check_special_character fs_conf hw_conf multi_conf \
                           net_conf script_init sys_conf                      \
                           Z_servicesEnDis Z_adduser Z_deleteuser Z_suspenduser depfinder ) 
        #______###______#
        ## Don't remove that anchor !
        fctlinuaz () {
        local fctlinua
        foreach fctlinua in $FCTLIST_ADM_LINU; do 
            autoload -U $fctlinua
        done            
        }
        fctlinuaz
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                             LINUX DAILY-USE FUNCTIONS                      |   
        # --------------------------------------------------------------------------------
        ## Don't remove that anchor !
        #______##______#
        FCTLIST_DAI_LINU=( speaky cdd tab)
        #______###______#
        ## Don't remove that anchor !
        fctlinuda() {
        local fctlinuda
        foreach fctlinuda in $FCTLIST_DAI_LINU; do 
            autoload -U $fctlinuda
        done             
        }
        fctlinuda       
        ###############################################################################    
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                             LINUX DEVELOPMENT FUNCTIONS                       |   
        # --------------------------------------------------------------------------------
        ## Don't remove that anchor !
        #______##______#
        FCTLIST_DEV_LINU=( )
        #______###______#
        ## Don't remove that anchor !
        
        
        fctlinude () {
        local fctlinude
        foreach fctlinude in $FCTLIST_DEV_LINU; do 
            autoload -U $fctlinude
        done            
        }
        fctlinude
        ###############################################################################    
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                                 LINUX MEDIA FUNCTIONS                           |   
        # --------------------------------------------------------------------------------
        ## Don't remove that anchor !
        #______##______#
        FCTLIST_MED_LINU=( gimpz movieme )
        #______###______#
        ## Don't remove that anchor !
        fctlinumz () {
        local fctlinum
        foreach fctlinum in $FCTLIST_MED_LINU; do 
            autoload -U $fctlinum
        done            
        }
        fctlinumz
        ###############################################################################    
        ###############################################################################
        # ------------------------------------------------------------------------------
        #                                                                               \
        # --------------------------------------------------------------------------------
        #                                 LINUX NETWORK FUNCTIONS                         |   
        # --------------------------------------------------------------------------------
        ## Don't remove that anchor !
        #______##______#
        FCTLIST_NET_LINU=( )
        #______###______#
        ## Don't remove that anchor !
        fctlinum () {
        local fctlinun
        foreach fctlinun in $FCTLIST_NET_LINU; do 
            autoload -U $fctlinun
        done
        }
        fctlinum
        # --------------------------------
        #                                 \ 
        # ---------------------------------
        #          MOZCORE_DEBUG          |  
        # --------------------------------- 
        ##
        # uncomment for debugging
        zshrc_primary_load_status "Linux functions set.\e[0m" 
    fi     
    ## end ## [[ $LOAD_ESSENTIAL_FUNCTIONS == 'YES' ]]
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
