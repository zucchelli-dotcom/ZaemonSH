# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#                  $ZDOT/zshrc.d/030_functions.distributed.zsh                    |
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
# File :  ${ZDOT}/zshrc.d/030_functions.distributed.zsh
# sourced from  /etc/zshrc
# Version : 2.0.0
# Native distributed zsh functions start here. You will probably want to edit this.
# On Darwin system they are normally in /usr/share/zsh/[ZSH_VERSION_NUMBER]/functions/
# folder.
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------
# 20/à7:2019
# • Investigate a little bits about distributed functions.


#---------------------------------------------------------------------------------
#                                     CHANGES
#---------------------------------------------------------------------------------
# 20/à7:2019
# • Add complete list of zsh 5.7 ditributed functions

#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------
if [[ -o interactive ]]; then
    ##uncomment to debug
    # {{{ Loading status
          zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
    #}}}

    # {{{ Loading status
         zshrc_load_status () { echo "${YEL}  + Distributed functions load:${GREY} $*${NC}"}
    #}}}
    # set these associated aliases:
    alias mmv='noglob zmv -W'   # user-friendly version of zmv
    # -----------------------------------------------------------------------------
    #                                                                               \
    # -------------------------------------------------------------------------------
    #                             ZSH DISTRIBUTED FUNCTIONS                          |
    # -------------------------------------------------------------------------------
     # Distributed functions sorted by category:
     # uncomment the line if you want to use one of these.
        # Misc
            autoload -U pick-web-browser

        # MIME
            autoload -U zsh-mime-handler
            autoload -U zsh-mime-setup
            autoload -U allopt
            autoload -U checkmail
            autoload -U colors
            autoload -U getjobs
            autoload -U harden
            autoload -U is-at-least
            autoload -U mere
            autoload -U promptnl
            autoload -U relative
            autoload -U tetris
            autoload -U zargs
            autoload -U zcalc
            autoload -U zed
            autoload -U zkbd
            autoload -U zrecompile
            autoload -U zstyle+
            autoload -U zmv

        # Prompts (these are not normally loaded)
        # Issue "Z_Switch_prompt" for a nice OS X gui
            # autoload -U prompt_adam1_setup
            # autoload -U prompt_adam2_setup
            # autoload -U prompt_bart_setup
            # autoload -U prompt_bigfade_setup
            # autoload -U prompt_clint_setup
            # autoload -U prompt_elite2_setup
            # autoload -U prompt_elite_setup
            # autoload -U prompt_fade_setup
            # autoload -U prompt_fire_setup
            # autoload -U prompt_off_setup
            # autoload -U prompt_oliver_setup
            # autoload -U prompt_pws_setup
            # autoload -U prompt_redhat_setup
            # autoload -U prompt_suse_setup
            # autoload -U prompt_walters_setup
            # autoload -U prompt_zefram_setup
            # autoload -U promptinit

        # TCP
            # autoload -U tcp_alias
            # autoload -U tcp_close
            # autoload -U tcp_command
            # autoload -U tcp_expect
            # autoload -U tcp_fd_handler
            # autoload -U tcp_log
            # autoload -U tcp_open
            # autoload -U tcp_output
            # autoload -U tcp_point
            # autoload -U tcp_proxy
            # autoload -U tcp_read
            # autoload -U tcp_rename
            # autoload -U tcp_send
            # autoload -U tcp_sess
            # autoload -U tcp_shoot
            # autoload -U tcp_spam
            # autoload -U tcp_talk
            # autoload -U tcp_wait

        #  Zftp
            # autoload -U zfanon
            # autoload -U zfautocheck
            # autoload -U zfcd
            # autoload -U zfcd_match
            # autoload -U zfcget
            # autoload -U zfclose
            # autoload -U zfcput
            # autoload -U zfdir
            # autoload -U zffcache
            # autoload -U zfgcp
            # autoload -U zfget
            # autoload -U zfget_match
            # autoload -U zfgoto
            # autoload -U zfhere
            # autoload -U zfinit
            # autoload -U zfls
            # autoload -U zfmark
            # autoload -U zfopen
            # autoload -U zfparams
            # autoload -U zfpcp
            # autoload -U zfput
            # autoload -U zfrglob
            # autoload -U zfrtime
            # autoload -U zfsession
            # autoload -U zfstat
            # autoload -U zftp_chpwd
            # autoload -U zftp_progress
            # autoload -U zftransfer
            # autoload -U zftype
            # autoload -U zfuget
            # autoload -U zfuput

        # Zle (these are not normally loaded outside of Zle)
            autoload -U backward-kill-word-match
            autoload -U backward-word-match
            autoload -U capitalize-word-match
            autoload -U copy-earlier-word
            autoload -U cycle-completion-positions
            autoload -U delete-whole-word-match
            autoload -U down-case-word-match
            autoload -U down-line-or-beginning-search
            autoload -U edit-command-line
            autoload -U define-composed-char
            autoload -U forward-word-match
            autoload -U history-beginning-search-menu
            autoload -U history-pattern-search
            autoload -U history-search-end
            autoload -U incarg
            autoload -U incremental-complete-word
            autoload -U insert-files
            autoload -U insert-composed-char
            autoload -U insert-unicode-char
            autoload -U kill-word-match
            autoload -U match-word-context
            autoload -U match-words-by-style
            autoload -U narrow-to-region
            autoload -U narrow-to-region-invisible
            autoload -U predict-on
            autoload -U quote-and-complete-word
            autoload -U read-from-minibuffer
            autoload -U replace-string
            autoload -U replace-string-again
            autoload -U select-word-style
            autoload -U smart-insert-last-word
            autoload -U transpose-words-match
            autoload -U up-case-word-match
            autoload -U up-line-or-beginning-search
            autoload -U url-quote-magic
            autoload -U zed-set-file-name




            ### VCS
            # autoload -U VCS_INFO_adjust
            # autoload -U VCS_INFO_bydir_detect
            # autoload -U VCS_INFO_check_com
            # autoload -U VCS_INFO_detect_bzr
            # autoload -U VCS_INFO_detect_cdv
            # autoload -U VCS_INFO_detect_cvs
            # autoload -U VCS_INFO_detect_darcs
            # autoload -U VCS_INFO_detect_fossil
            # autoload -U VCS_INFO_detect_git
            # autoload -U VCS_INFO_detect_hg
            # autoload -U VCS_INFO_detect_mtn
            # autoload -U VCS_INFO_detect_p4
            # autoload -U VCS_INFO_detect_svk
            # autoload -U VCS_INFO_detect_svn
            # autoload -U VCS_INFO_detect_tla
            # autoload -U VCS_INFO_formats
            # autoload -U VCS_INFO_get_cmd
            # autoload -U VCS_INFO_get_data_bzr
            # autoload -U VCS_INFO_get_data_cdv
            # autoload -U VCS_INFO_get_data_cvs
            # autoload -U VCS_INFO_get_data_darcs
            # autoload -U VCS_INFO_get_data_fossil
            # autoload -U VCS_INFO_get_data_git
            # autoload -U VCS_INFO_get_data_hg
            # autoload -U VCS_INFO_get_data_mtn
            # autoload -U VCS_INFO_get_data_p4
            # autoload -U VCS_INFO_get_data_svk
            # autoload -U VCS_INFO_get_data_svn
            # autoload -U VCS_INFO_get_data_tla
            # autoload -U VCS_INFO_hexdump
            # autoload -U VCS_INFO_hook
            # autoload -U VCS_INFO_maxexports
            # autoload -U VCS_INFO_nvcsformats
            # autoload -U VCS_INFO_patch2subject
            # autoload -U VCS_INFO_quilt
            # autoload -U VCS_INFO_reposub
            # autoload -U VCS_INFO_set
            # autoload -U VCS_INFO_set-patch-format

        #####
        #/!\#
        #####
            autoload -U age
            autoload -U backward-kill-word-match
            autoload -U backward-word-match
            autoload -U bashcompinit
            autoload -U calendar
            autoload -U calendar_add
            autoload -U calendar_edit
            autoload -U calendar_lockfiles
            autoload -U calendar_parse
            autoload -U calendar_read
            autoload -U calendar_scandate
            autoload -U calendar_show
            autoload -U calendar_showdate
            autoload -U calendar_sort
            autoload -U catch
            autoload -U cdr
            autoload -U chpwd_recent_add
            autoload -U chpwd_recent_dirs
            autoload -U chpwd_recent_filehandler
            autoload -U keeper
            autoload -U keymap+widget
            autoload -U modify-current-argument
            autoload -U move-line-in-buffer
            autoload -U nslookup
            autoload -U regexp-replace
            autoload -U run-help-openssl
            autoload -U run-help-p4
            autoload -U run-help-sudo
            autoload -U send-invisible
            autoload -U split-shell-arguments
            autoload -U sticky-note
            autoload -U throw
            autoload -U transpose-lines
            autoload -U xtermctl
            autoload -U zmathfuncdef
            autoload -U zsh-mie-contexts
            autoload -U zsh-newuser-install
            autoload -U zsh_directory_name_cdr
            autoload -U ztodo

################################################
#                TO ODER
################################################
            autoload -U add-zle-hook-widget
            autoload -U add-zsh-hook
            autoload -U after

            autoload -U before
            autoload -U bracketed-paste-magic
            autoload -U bracketed-paste-url-magic

            autoload -U chpwd_recent_add
            autoload -U chpwd_recent_dirs
            autoload -U chpwd_recent_filehandler

            # autoload -U compaudit
            # autoload -U compdump
            # autoload -U compinit
            # autoload -U compinstall

            autoload -U expand-absolute-path

            autoload -U keymap+widget
            autoload -U kill-word-match
            autoload -U match-word-context
            autoload -U match-words-by-style
            autoload -U mere
            autoload -U modify-current-argument
            autoload -U move-line-in-buffer
            autoload -U narrow-to-region
            autoload -U narrow-to-region-invisible
            autoload -U nslookup
            autoload -U pick-web-browser
            autoload -U predict-on

            autoload -U promptnl
            autoload -U quote-and-complete-word
            autoload -U read-from-minibuffer
            autoload -U regexp-replace
            autoload -U relative
            autoload -U replace-argument

            autoload -U run-help
            autoload -U run-help-git
            autoload -U run-help-ip
            autoload -U run-help-svk
            autoload -U run-help-svn
            autoload -U select-bracketed
            autoload -U select-quoted
            autoload -U select-word-match
            autoload -U surround

            autoload -U tetriscurses
            autoload -U throw
            autoload -U transpose-lines
            autoload -U transpose-words-match

            autoload -U vcs_info
            autoload -U vcs_info_hookadd
            autoload -U vcs_info_hookdel
            autoload -U vcs_info_lastmsg
            autoload -U vcs_info_printsys
            autoload -U vcs_info_setsys
            autoload -U vi-pipe
            autoload -U which-command
            autoload -U xtermctl

            autoload -U zcalc-auto-insert

            autoload -U zed-set-file-name

            autoload -U zmathfunc
            autoload -U zmathfuncdef

            autoload -U zsh-mime-contexts

            autoload -U zsh-newuser-install
            autoload -U zsh_directory_name_cdr
            autoload -U zsh_directory_name_generic
        #####
        #/!\#
        #####
        # site-functions
    # --------------------------------
    #                                 \
    # ---------------------------------
    #         ZEAMONSH-DEBUG           |
    # ---------------------------------
    # uncomment for debugging
    zshrc_primary_load_status "Distributed zsh functions set."
fi
