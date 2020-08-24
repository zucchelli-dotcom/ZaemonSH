# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#              $ZDOT/zshrc.d/111_environment.options.zsh                          |
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
# File:  $ZDOT/zshrc.d/111_environment.options.zsh
# sourced from /etc/zshrc
# Version: 2.0.0
# Most of what follows is distributed with ZSH:
# Housekeeping, Completions, environment Options,
# Keybindings and and zstyles
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                     CHANGES
#---------------------------------------------------------------------------------
# 14/01/2018 :
#  • Add noglobalrcs, The result is that the files /etc/zprofile,
#  /etc/zshrc and /etc/zlogin

#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------
if [[ -o interactive ]]; then
 ##uncomment to debug
 # {{{ Loading status
 zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
 #}}}

 # {{{ Loading status
 zshrc_load_status () { echo "${YEL}  + Environment load:${GREY} $*${NC}"}
 #}}}

# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                        SETTINGS FOR UMASK                                       |
# --------------------------------------------------------------------------------
    if [[ $IS_ROOT ]]; then
       umask 002
    else
       umask 022
    fi
    #####
    function _exit()        # function to run upon exit of shell
    {
        clear
        echo -e "[1;31mHasta la vista, baby![0m"
    }
    trap _exit 0

 function _return()        # function to run upon exit of shell
    {
        clear
        echo -e "[1;31mHasta la vista, baby![0m"
    }
    trap _return 0

###############################################################################
###############################################################################
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                        CUSTOM COMPLETIONS                                      |
# --------------------------------------------------------------------------------
    # Load our additional cusom completions here
    compctl -D -f + -U -Q -K multicomp

    # I have removed compctl from the distribution and moved everything into
    # zsh completion functions, so this is for any legacy script.
    [[ -f $ZDOT/compctl ]] && source $ZDOT/compctl

    ZSH_VERSION_TYPE=new
    # {{{ Profiling

    [[ -n "$ZSH_PROFILE_RC" ]] && which zmodload >&/dev/null && zmodload zsh/zprof
    # }}}

    #}}}

    # {{{ Options

###############################################################################
###############################################################################
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                        SETTINGS ZSH ENVIRONMENT OPTIONS                         |
# --------------------------------------------------------------------------------

    ## Uncommment to debug
    zshrc_load_status "Zsh options set"

#############################
#  By defaults on zshr 5.7  #
#############################
## is ON
# is OFF
                ## aliases            \
                # aliasfuncdef        \
                # allexport           \
                ## alwayslastprompt    \
                # alwaystoend         \   # Move cursor to the end of a completed word.
                ## appendcreate        \
                # appendhistory       \
                #x autocd              \ # Auto changes to a directory without typing cd.
                # autocontinue        \
                ## autolist            \ # Automatically list choices on ambiguous completion.
                # automenu            \  # Show completion menu on a succesive tab press.
                # autonamedirs        \ # Auto add variable-stored paths to ~ list.
                ## autoparamkeys       \
                ## autoparamslash      \ # If completed parameter is a directory, add a trailing slash.
                # autopushd           \ # Push the old directory onto the stack on cd.
                # autoremoveslash     \ # List jobs in the long format by default
            # autoresume          \ # Attempt to resume existing job before creating a new process.
                ## badpattern          \
                ## banghist            \
                ## bareglobqual        \
                # bashautolist        \
                # bashrematch         \
                ## beep                \
                ## bgnice              \
                # braceccl            \ # Allow brace character class list expansion.
                # bsdecho             \
                ## caseglob            \
                ## casematch           \
                # cbases              \
                # cdablevars          \  # Change directory to a path stored in a variable.
                # chasedots           \
                # chaselinks          \
                ## checkjobs           \
                ## checkrunningjobs    \
                ## clobber             \
                # combiningchars      \
                # completealiases     \
                # completeinword      \ # Complete from both ends of a word.
                # continueonerror     \
                # correct             \
                # correctall          \
                # cprecedences        \
                # cshjunkiehistory    \
                # cshjunkieloops      \
                # cshjunkiequotes     \
                # cshnullcmd          \
                # cshnullglob         \
                ## debugbeforecmd      \
                # dvorak              \
                # emacs               \
                ## equals              \
                # errexit             \
                # errreturn           \
                ## evallineno          \
                ## exec                \
                # extendedglob        \ # Use extended globbing syntax
                # extendedhistory     \
                ## flowcontrol         \ # Disable start/stop characters in shell editor.
                # forcefloat          \
                ## functionargzero     \
                ## glob                \
                ## globalexport        \
                ## globalrcs           \
                # globassign          \
                # globcomplete        \
                # globdots            \
                # globstarshort       \
                # globsubst           \
                ## hashcmds            \
                ## hashdirs            \
                # hashexecutablesonly \
                ## hashlistall         \
                # histallowclobber    \
                ## histbeep            \
                # histexpiredupsfirst \
                # histfcntllock       \
                # histfindnodups      \
                # histignorealldups   \
                # histignoredups      \
                # histignorespace     \
                # histlexwords        \
                # histnofunctions     \
                # histnostore         \
                ## histreduceblanks    \
                ## histsavebycopy      \
                # histsavenodups      \
                # histsubstpattern    \
                # histverify          \
                # hup                 \
                # ignorebraces        \
                # ignoreclosebraces   \
                # ignoreeof           \
                # incappendhistory    \
                # incappendhistorytime \
                ## interactive         \
                # interactivecomments \
                # ksharrays           \
                # kshautoload         \
                # kshglob             \
                # kshoptionprint      \
                # kshtypeset          \
                # kshzerosubscript    \
                ## listambiguous       \
                ## listbeep            \
                # listpacked          \
                # listrowsfirst       \
                ## listtypes           \
                # localloops          \
                # localoptions        \
                # localpatterns       \
                # localtraps          \
                ## login               \
                # longlistjobs        \ # List jobs in the long format by default
                # magicequalsubst     \
                # mailwarning         \ # Print a warning message if a mail file has been accessed.
                # markdirs            \
                # menucomplete        \  # Do not autoselect the first completion entry.
                # monitor             \
                ## multibyte           \
                ## multifuncdef        \
                ## multios             \ # Write to multiple descriptors.
                ## nomatch             \
                ## notify              \
                # nullglob            \
                # numericglobsort     \
                # octalzeroes         \
                # overstrike          \
                # pathdirs            \ # Perform path search even on command names with slashes.
                # pathscript          \
                # pipefail            \
                # posixaliases        \
                # posixargzero        \
                # posixbuiltins       \
                # posixcd             \
                # posixidentifiers    \
                # posixjobs           \
                # posixstrings        \
                # posixtraps          \
                # printeightbit       \
                # printexitvalue      \
                # privileged          \
                # promptbang          \
                ## promptcr            \
                ## promptpercent       \
                ## promptsp            \
                # promptsubst         \
                # pushdignoredups     \ # Do not store duplicates in the stack.
                # pushdminus          \
                # pushdsilent         \ # Do not print the directory stack after pushd or popd.
                # pushdtohome         \ # Push to home directory when no argument is given.
                # rcexpandparam       \
                # rcquotes            \ # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
                ## rcs                 \
                # recexact            \
                # rematchpcre         \
                # restricted          \
                # rmstarsilent        \
                # rmstarwait          \
                ## sharehistory        \
                # shfileexpansion     \
                # shglob              \
                ## shinstdin           \
                # shnullcmd           \
                # shoptionletters     \
                ## shortloops          \
                # shwordsplit         \
                # singlecommand       \
                # singlelinezle       \ # /!\If it is desactivated prompt_bz_setup RPS1 became fluxy!
                # sourcetrace         \
                # sunkeyboardhack     \
                # transientrprompt    \
                # trapsasync          \
                # typesetsilent       \
                ## unset               \
                # verbose             \
                # vi                  \
                # warncreateglobal    \
                # warnnestedvar       \
                # xtrace              \   #   # /!\ Good for debugging /!\ # #
                # zle                 \
    setopt                       \
            noglobalrcs          \
            append_history       \
            auto_list            \
            auto_menu            \
            auto_param_keys      \
         NO_auto_pushd           \
            bad_pattern          \
            bang_hist            \
            brace_ccl            \
            correct_all          \
            cdable_vars          \
         NO_chase_links          \
         NO_clobber              \
            complete_in_word     \
         NO_csh_junkie_loops     \
         NO_csh_junkie_quotes    \
         NO_csh_null_glob        \
            extended_glob        \
            function_argzero     \
            glob                 \
         NO_glob_assign          \
            glob_complete        \
         NO_glob_dots            \
         NO_glob_subst           \
            hash_cmds            \
            hash_dirs            \
            hash_list_all        \
            hist_allow_clobber   \
            hist_beep            \
            histallowclobber     \
         NO_hup                  \
         NO_ignore_braces        \
            ignore_eof           \
            interactive_comments \
         NO_list_ambiguous       \
            list_types           \
            long_list_jobs       \
            magic_equal_subst    \
         NO_mark_dirs            \
            multios              \
            nomatch              \
            nohup                \
            notify               \
            nocheckjobs          \
         NO_null_glob            \
            path_dirs            \
            posix_builtins       \
            print_exit_value     \
            pushd_ignore_dups    \
         NO_pushd_minus          \
            pushd_to_home        \
            rc_expand_param      \
         NO_rc_quotes            \
         NO_rm_star_silent       \
         NO_sh_file_expansion    \
            short_loops          \
            zle                  \
         NO_single_line_zle      \
         NO_sun_keyboard_hack    \
            unset                \
            c_bases              \
            octal_zeroes         \
        NO_verbose

    if [[ $ZSH_VERSION_TYPE == 'new' ]]; then
      setopt hist_reduce_blanks
    fi


    # {{{ Watching for other users
    LOGCHECK=60
    WATCHFMT="[%B%t%b] %B%n%b has %a %B%l%b from %B%M%b"

    # }}}
    # {{{ Completions

###############################################################################
###############################################################################
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                        STANDARD ZSH COMPLETIONS                                 |
# --------------------------------------------------------------------------------

    autoload -U compinit
    compinit -C # don't perform security check
    #

    # {{{ (host, port, user) triples for telnet
    telnet_users_hosts_ports=(
    )
    zstyle ':completion:*:*:telnet:*' users-hosts-ports $telnet_users_hosts_ports
    # reverse unwanted aliasing of `which' by distribution startup
    # files (e.g. /etc/profile.d/which*.sh); zsh's which is perfectly
    # good as is.

        ## Uncommment to debug
    zshrc_load_status "Zsh completion system set."


    alias which >&/dev/null && unalias which

    # }}}
    # {{{ run-help

    alias run-help >&/dev/null && unalias run-help
    autoload run-help

    # }}}

    # {{{ Restarting zsh or bash; reloading .zshrc or functions
    bash () {
      NO_SWITCH="yes" PS1='\h:\W \u\$ ' command bash "$@"
    }

    # Z_restart () {
    #   exec $SHELL -l  $SHELL_ARGS "$@"
    # }

    Z_profile () {
      ZSH_PROFILE_RC=1 $SHELL "$@"
    }
    Z_restrictive () {
    # When the basename of the command used to invoke zsh starts with the letter ‘r’ or the ‘-r’
    # command line option is supplied at invocation, the shell becomes restricted. Emulation mode is
    # determined after stripping the letter ‘r’ from the invocation name. The following are disabled
    # in restricted mode:
    #  changing directories with the cd builtin

    #  changing or unsetting the
    #     PATH, path, MODULE_PATH, module_path, SHELL, HISTFILE,
    #     HISTSIZE, GID, EGID, UID, EUID, USERNAME, LD_LIBRARY_PATH, LD_AOUT_LIBRARY_PATH,
    #     LD_PRELOAD and LD_AOUT_PRELOAD parameters
    #  specifying command names containing /

    #  specifying command pathnames using hash

    #  redirecting output to files

    #  using the exec builtin command to replace the shell with another command

    #  using jobs -Z to overwrite the shell process’ argument and environment space
    #  using the ARGV0 parameter to override argv[0] for external commands

    #  turning off restricted mode with set +r or unsetopt RESTRICTED

    # These restrictions are enforced after processing the startup files. The startup files should set
    # up PATH to point to a directory of commands which can be safely invoked in the restricted
    # environment. They may also add further restrictions by disabling selected builtins.
    # Chapter 5: Files 8
    # Restricted mode can also be activated any time by setting the RESTRICTED option.
      # zsh -r .zshrc
      # zsh -o RESTRICTED
    }

    # Z_reload () {
    #  if [[ "$#" -eq 0 ]]; then
    #    #. $zdotdir/.zshrc
    #    . $HOME/.zshrc
    #  else
    #    local fn
    #    for fn in "$@"; do
    #      unfunction $fn
    #      autoload -U $fn
    #    done
    #  fi
    #}
    #compdef _functions reload
# --------------------------------
#                                 \
# ---------------------------------
#         ZEAMONSH-DEBUG           |
# ---------------------------------
    ##
    # uncomment for debugging
zshrc_primary_load_status "Zsh Environment options set."
fi
# }}}

# }}}


