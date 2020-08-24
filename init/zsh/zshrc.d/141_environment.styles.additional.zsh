# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#              $ZDOT/zshrc.d/140_environment.styles.main.zsh                      |
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
# File:  $ZDOT/zshrc.d/140_environment.styles.main.zsh
# sourced from /etc/zshrc
# Version: 2.0.0
# Most of what follows is distributed with ZSH
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                     CHANGES
#---------------------------------------------------------------------------------
# 19/09/2007 :
# • Williams scott create this one.


# 19/09/2019 :
# • Remove all part related to grmlrc. Host and User completion not working good
#   with eat.

#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------

###################################################################################
###################################################################################
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                         ADDITIONAL ENVIRONMENT STYLE                           |
# --------------------------------------------------------------------------------
##uncomment to debug
# {{{ Loading status
    zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
#}}}

# {{{ Loading status
    zshrc_load_status () { echo "${YEL}  + Environment keybinding zshall load:${GREY} $*${NC}"}
#}}}


# Share history between terminal sessions
# Useful for multi-terminal environment
setopt share_history
zmodload -i zsh/complist  2>/dev/null

# Ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# Completing process IDs with menu selection:
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# Don't complete uninteresting users...
zstyle ':completion:*:*:*:users' ignored-patterns \
adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
mailman mailnull mldonkey mysql nagios \
named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
operator pcap postfix postgres privoxy pulse pvm quagga radvd \
rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# Media Players
zstyle ':completion:*:*:mpg123:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:mpg321:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
zstyle ':completion:*:*:ogg123:*' file-patterns '*.(ogg|OGG|flac):ogg\ files *(-/):directories'
zstyle ':completion:*:*:mocp:*' file-patterns '*.(wav|WAV|mp3|MP3|ogg|OGG|flac):ogg\ files *(-/):directories'

# Mutt
if [[ -s "$HOME/.mutt/aliases" ]]; then
  zstyle ':completion:*:*:mutt:*' menu yes select
  zstyle ':completion:*:mutt:*' users ${${${(f)"$(<"$HOME/.mutt/aliases")"}#alias[[:space:]]}%%[[:space:]]*}
fi

# SSH/SCP/RSYNC
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\         address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost  ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[: alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].    ]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# Ping/Traceroute
compdef ping6=ping
compdef traceroute6=traceroute

# Auto expand global aliases
local min_zsh_version='4.3.9'
if ! autoload -Uz is-at-least || ! is-at-least "$min_zsh_version"; then
  return 1
fi

# if zstyle -t ':dotzsh:module:completion' expand-global-aliases; then
  globalias() {
    if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
      zle _expand_alias
    fi
   zle self-insert
  }

  zle -N globalias

  bindkey " " globalias
  bindkey "^ " magic-space           # control-space to bypass completion
  bindkey -M isearch " " magic-space # normal space during searches
# fi

# ... unless we really want to.
# zstyle '*' single-ignored show

if [[ $IS_MAC ]]; then

    # Make one-way case insensitivity (for cd and cdd commands) for (Directory) completion
    #   zstyle ':completion:*:*:*:*' matcher-list 'm:{a-z}={A-Z}'
    #   zstyle ':completion:*:*:cd:*' matcher-list 'm:{a-z}={A-Z}'
    # For open completion
    zstyle ':completion:*:*:open:*' matcher 'm:{a-z}={A-Z} r: ||[^ ]=**'


    # If you want a Pashua GUI menu of completion options as a default
    # for the "open -a Foo.app" command, then set the variable OPEN_PASHUA
    # to 'yes' by removing the comment sign from the following line:
    # export OPEN_PASHUA='yes'


    # This groups sets of completions for alternatives (#globally | for the mdfind command)
    # zstyle ':completion:*' group-name ''
    zstyle ':completion:*:*:_mdfind:*' group-name ''

fi

### Sudo functions
zstyle ':completion:*:sudo:*' environ
PATH="$SUDO_PATH:$PATH"
zstyle ':completion:*:*:-command-:*' group-order aliases functions commands
# --------------------------------
#                                 \
# ---------------------------------
#         ZEAMONSH-DEBUG           |
# ---------------------------------
##
# uncomment for debugging
zshrc_primary_load_status "Environment additionnal styles set."
