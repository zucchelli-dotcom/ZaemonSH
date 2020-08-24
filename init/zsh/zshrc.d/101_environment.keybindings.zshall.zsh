# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |   
#                                - ZAEMONSH -                                     |
#              $ZDOT/zshrc.d/101_environment.keybindings.zshall.zsh               |
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
# File:  $ZDOT/zshrc.d/101_environment.keybindings.zshall.zsh
# sourced from /etc/zshrc
# Version: 2.0.0
# Use this for all zsh keybindings AFTER emacs or vi is chosen
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                     CHANGES
#---------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------
if [[ -o interactive ]]; then
       ##uncomment to debug
       # {{{ Loading status
           zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
       #}}}

       # {{{ Loading status
           zshrc_load_status () { echo "${YEL}  + Environment keybinding zshall load:${GREY} $*${NC}"}
       #}}}   
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                   TODO                                   		|   
# --------------------------------------------------------------------------------	
# if you’re used to pressing q to exit from your pager, you might be
# interested in this
# bindkey -M listscroll q send-break

# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                            KEYBINDINGS ZSHALL                                   |   
# --------------------------------------------------------------------------------	
## ZLE tweaks ##
## use the vi navigation keys (hjkl) besides cursor keys in menu completion
#bindkey -M menuselect 'h' vi-backward-char        # left
#bindkey -M menuselect 'k' vi-up-line-or-history   # up
#bindkey -M menuselect 'l' vi-forward-char         # right
#bindkey -M menuselect 'j' vi-down-line-or-history # bottom
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
#####
#/!\#
#####
#bindkey -M menuselect '\C-o' accept-and-menu-complete
## set command prediction from history, see 'man 1 zshcontrib'
# is4 && zrcautoload predict-on && \
# zle -N predict-on         && \
# zle -N predict-off        && \
# bindkey "^X^Z" predict-on && \
# bindkey "^Z" predict-off

## press ctrl-q to quote line:
mquote () {
     zle beginning-of-line
     zle forward-word
     # RBUFFER="'$RBUFFER'"
     RBUFFER=${(q)RBUFFER}
     zle end-of-line
}
zle -N mquote && bindkey '^q' mquote

## define word separators (for stuff like backward-word, forward-word, backward-kill-word,..)
WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>' # the default
WORDCHARS=.
WORDCHARS='*?_[]~=&;!#$%^(){}'
WORDCHARS='${WORDCHARS:s@/@}'

# just type '...' to get '../..'
# rationalise-dot() {
# local MATCH
# if [[ $LBUFFER =~ '(^|/| |	|'$'\n''|\||;|&)\.\.$' ]]; then
#  LBUFFER+=/
#  zle self-insert
#  zle self-insert
# else
#  zle self-insert
# fi
# }
# zle -N rationalise-dot
# bindkey . rationalise-dot
# without this, typing a . aborts incremental history search
bindkey -M isearch . self-insert
bindkey '\eq' push-line-or-edit
bindkey ' ' magic-space
zshrc_load_status '+ zshall key bindings'
# command zle -la  produces a list of possible commands
# command bindkey -L produces a list of keys and their current bindings
# Fix weird sequence that rxvt produces
bindkey -s '^[[Z' '\t'
# alias no=ls  # for Dvorak
#bindkey '^L' push-input # /!\ Conflict with clear screen
bindkey -s '^X^Z' '%-^M'
bindkey '^[e' expand-cmd-path
#bindkey -s '^X?' '\eb=\ef\C-x*'
bindkey '^[^I' reverse-menu-complete
bindkey '^X^N' accept-and-infer-next-history
bindkey '^[P' history-beginning-search-backward
bindkey '^[N' history-beginning-search-forward
bindkey '^[b' emacs-backward-word
bindkey '^[f' emacs-forward-word
bindkey '^[v' expand-or-complete-prefix
# Key Up(arrow) and Key Down(arrow)
bindkey '\e[A'  history-search-backward  # Up
bindkey '\e[B'  history-search-forward   # Down
#bindkey '\e[A'  up-line-or-history      # Up
#bindkey '\e[B'  down-line-or-history    # Down
# Key Right(arrow) and Key Left(arrow)
bindkey '\e\e[C' forward-word            # Right
bindkey '\e\e[D' backward-word           # Left
    # Key Home and Key End
    # May have to be configured within the terminal emulator
	if [[  ( $TERM_PROGRAM == iTerm.app )  ]];then
		#### iTerm.app on OS X possible options
		if [[ $TERM == "xterm" ]];then
	    	bindkey '^[[7~'  beginning-of-line        				# Home
	    	bindkey '^[[8~'  end-of-line              				# End
		elif [[ $TERM == "vt100" ]];then
			bindkey '^[Oq'  beginning-of-line         				# Home
			bindkey '^[Op'  end-of-line               				# End
		elif [[ $TERM == "linux" ]]; then
	    	bindkey '^[[1~'  beginning-of-line        				# Home
	    	bindkey '^[[4~'  end-of-line              				# End
		elif [[ $TERM == "ansi" ]]; then
		    bindkey '^[[H'  beginning-of-line        				# Home
		    bindkey '^[[F'  end-of-line              				# End
		else  
	        true
		fi
	elif [[  $TERM_PROGRAM == (Apple_Terminal)  ]]; then

		#### Terminal.app on OS X possible options
		# Needs to be configured within the Terminal.app Preferences
		true
	
	elif [[ $TERM_PROGRAM == rxvt ]]  && [[ "$OSTYPE" =~ ^(darwin)+ ]] || [[ $COLORTERM == *rxvt* ]]; then
		#### rxvt  
		bindkey '^[[7~'  beginning-of-line        					# Home
		bindkey '^[[8~'  end-of-line              					# End
		
	elif [[ $COLORTERM == (Terminal|gnome-terminal|xfce4-terminal) ]];then
		#### xfce4 Terminal
		       bindkey '^[OH'  beginning-of-line        			# Home
		       bindkey '^[OF'  end-of-line              			# End
		
	elif [[ -n $KONSOLE_DBUS_SERVICE || $TERM_PROGRAM == konsole ]]; then
	    bindkey '^[[H'  beginning-of-line        				# Home
	    bindkey '^[[F'  end-of-line              				# End
	
	elif [[ $TERM_PROGRAM == xterm ]] && [[ "$OSTYPE" =~ ^(darwin)+ ]] || [[ $TERM == xterm ]]; then
		#### xterm  
	    bindkey '^[[H'  beginning-of-line        					# Home
	    bindkey '^[[F'  end-of-line              					# End	
	
	else
		# Other options?
		true
	fi
   
    # Key PageUp and Key PageDown
	    # Note that PageUp and PageDown and/or
	    # ^PageUp and ^PageDown are usually intercepted by the 
	    # terminal emulator.  Therefore, you will likely have to
	    # configure these within the terminal emulator itself.
	    # Typical xterm/linux values
	    # bindkey '^[[5~' foo  # PageUp
	    # bindkey '^[[6~' bar  # PageDown
# --------------------------------
#                                 \ 
# ---------------------------------
#         ZEAMONSH-DEBUG           |        
# --------------------------------- 
    ##
    # uncomment for debugging
    zshrc_primary_load_status "Keybindings zshall environment set."
fi
