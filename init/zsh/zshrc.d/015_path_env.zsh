# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                                                                                 |
#                                - ZAEMONSH -                                     |
#                        $ZDOT/zshrc.d/007_path_env.zsh                           |
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
# File :  ${ZDOT}/zshrc.d/007_path_env.zsh
# sourced from  /etc/zshrc
# Version : 2.0.0
# First, disable the zsh-newuser-install mechanism, as it can confuse the new
# user of these files. Do this by creating an empty ~/.zshrc file if none
# currently exists.
# --------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#                                      TODO
#---------------------------------------------------------------------------------
# 2020-03-08 :
# • making an user and global installation and changing Zaemon location path accordilly

#---------------------------------------------------------------------------------
#                                     CHANGES
#---------------------------------------------------------------------------------
# 16/07/2019 :
# • Add clear pathelper routine
# 30/07/2019 :
# • Add avr binaries if Arduino.app exist, on non exotic place.
# 18/08/2019 :
# • Add VMware binaries.
# 20/02/2019 :
# • Add unset SYSAPPSEARCH  USERAPPSEARCH SYSAPPUTISEARCH
# 2020-03-08 :
# • Correcting alert with $MANPATH in LINUX --> manpath: attention : la variable $MANPATH est positionnée, /etc/man_db.conf est ignoré 
 
#---------------------------------------------------------------------------------
#                                  CONFIGURATION
#---------------------------------------------------------------------------------
 ##uncomment to debug
 # {{{ Loading status
 zshrc_primary_load_status() { echo "${WG}${NC}\033[1;32m $* \e[0m" }
 #}}}

 # {{{ Loading status
 zshrc_load_status () { echo "${YEL}  + Path environmentoptions load:${GREY} $*${NC}"}
 #}}}
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                           ZAEMON CONFIGURATION FILES                            |
# --------------------------------------------------------------------------------
if [[ ! -f  ~/.zshrc ]];then
   touch ~/.zshrc
fi

# Make the ~/.zsh directory if it does not yet exist.
if [[ ! -d ~/.zsh ]]; then
   mkdir -p ~/.zsh
fi

# All of the rc files created for user control go into the hidden home directory ~/.zsh
if [[ -d ${HOME}/.zsh ]]; then
	mkdir -p ~/.zsh
fi

###############################################################################
###############################################################################
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                          INITIAL CONDITIONNAL PATH                              |
# --------------------------------------------------------------------------------
# Establish initial conditions for $PATH and $MANPATH consistent with expected behavior:
# You should, as a bare minimum, have $MINPATH in your OS X $PATH:
if [[ $IS_MAC ]] && [[ -x /usr/libexec/path_helper ]]; then
    PATH=''
    # Mac OS X uses path_helper and /etc/paths.d to preload PATH, clear it out
    eval `/usr/libexec/path_helper -s`
    # eval $(/usr/libexec/path_helper -s ) # Done in zshenv_master
    # Minimal $PATH set automatically
    MIN_PATH=${PATH}:/usr/libexec
    # Minimal $MANPATH set automatically
    MANPATH=${MANPATH}
else
    # Alternative Minimal $PATH set manually
    MIN_PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/libexec
    MIN_PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/libexec

    # Alternative Minimal $MANPATH set manually
    if [[ -d /usr/X11/share/man ]]; then
        MANPATH=/usr/share/man:/usr/X11/share/man
	elif [[ -d /usr/X11R6/share/man ]]; then
	    MANPATH=/usr/share/man:/usr/X11R6/share/man
	else
	    MANPATH=/usr/share/man
	fi
fi

###############################################################################
###############################################################################
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                           ZAEMON LOCATION PATH                                  |
# --------------------------------------------------------------------------------
# If the user installed everything in $ZDOT_USER and $ZDOTDIR is nonexistent, attempt
# to globally adjust everything to accomidate this change Likewise for the
# fink-installed version.
if [[ ! -d $ZDOT && -d $ZDOT_TEMPLATE ]];then
    ZDOT="$ZDOT_TEMPLATE"
    export ZDOT
    # Notify user of what is happening:
    if [[ -z $SSH_CONNECTION && -o interactive ]];then
        print "Using template files installed in $ZDOT"
    fi
elif [[ ! -d $ZDOT && -d $ZDOT_USER ]];then
    ZDOT="$ZDOT_USER"
    export ZDOT
    # Notify user of what is happening:
    if [[ -z $SSH_CONNECTION && -o interactive ]];then
        print "Using template files installed in $ZDOT"
    fi
fi

###############################################################################
###############################################################################
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                         HERE WE ADD THE PATH:                                  |
# --------------------------------------------------------------------------------
# Then PREPEND or APPEND these to $PATH only if they exist:
# Note that $SWPREFIX/bin and $SWPREFIX/sbin were *prepended* at the top of the file
# if you installed fink in $SWPREFIX, you don't need to add these again.  However,
# to ensure the desired priority ordering, I do the following, which together with the
# typeset -U command, allows fine-tuning of the order without either duplicating or
# accidently deleting anything from $PATH :
if [[ $IS_MAC ]];then
    ### For Fink, if present
    if [[ $HAS_FINK ]] && [[ -d $SWPREFIX/bin ]]; then
        PREPEND_PATH=$SWPREFIX/bin:$SWPREFIX/sbin
    fi

    ### For MacPorts, if present
    if [[ $HAS_PORT ]] && [[ -d /opt/local/bin ]]; then
       	PREPEND_PATH=/opt/local/bin:/opt/local/sbin:$PREPEND_PATH
    fi

    ### For Homebrew, if present
     if [[ $HAS_BREW ]] && [[ -d /usr/local/bin ]]; then
         PREPEND_PATH=/usr/local/bin:$PREPEND_PATH
        # # If you need to have openssl@1.1 first in your PATH run:
        if [[ "/usr/local/opt/openssl@1.1/bin" ]]; then

        # openssl@1.1 is keg-only, which means it was not symlinked into /usr/local,
        # because openssl/libressl is provided by macOS so don't link an incompatible version.
        # If you need to have openssl@1.1 first in your PATH run:
        export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

        #For compilers to find openssl@1.1 you may need to set:
          export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
          export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

        #For pkg-config to find openssl@1.1 you may need to set:
          export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
        fi
     fi

#### For XQuartz, if present
    if [[ -d /opt/X11/bin ]]; then
        APPEND_PATH=/opt/X11/bin:$APPEND_PATH
    fi
# --------------------------------
#                                 \
# ---------------------------------
#         ZEAMONSHCORE_DEBUG       |
# ---------------------------------
 # {{{ Loading status
   zshrc_primary_load_status() { echo "${GREEN} [ OK ]${NC}\033[1;32m $* \e[0m" }
 #}}}

 # {{{ Loading status
   zshrc_load_status () { echo "${YEL}    ++ Environment path options load:${GREY} $*${NC}"}
 #}}}


# Now it should work like $PATH and $path
    #### For X11, if present
    if [[ -d /usr/X11/bin ]]; then
        APPEND_PATH=/usr/X11/bin:$APPEND_PATH
    elif [[ -d /usr/X11R6/bin ]]; then
        APPEND_PATH=/usr/X11R6/bin:$APPEND_PATH
    fi

    #### For Developer Tools, if present
    if [[ -d /Developer/Tools ]]; then
        APPEND_PATH=/Developer/Tools:$APPEND_PATH
    fi

    #### For CommandLine Tools, if present
    if [[ -d /Library/Developer/CommandLineTools/usr/bin ]]; then
        APPEND_PATH=/Library/Developer/CommandLineTools/usr/bin:$APPEND_PATH
    fi

    #### For user-installed python framework, if present
    if [[ -d /Library/Frameworks/Python.framework/Vpromersions/Current/bin ]];then
        APPEND_PATH=$APPEND_PATH:/Library/Frameworks/Python.framework/Versions/Current/bin
    fi

    #### For AquaTclTk, if present
    if [[ -d /Library/Tcl/bin ]]; then
        APPEND_PATH=$APPEND_PATH:/Library/Tcl/bin
    fi
    ### Add avr and co binaries if Arduino exit
    local SYSAPPSEARCH=$(ls /Applications 2>/dev/null | grep Arduino.app)
    local USERAPPSEARCH=$(ls $HOME/Applications 2>/dev/null | grep Arduino.app)
    if [ $SYSAPPSEARCH ]; then
        APPEND_PATH=$APPEND_PATH:/Applications/Arduino.app/Contents/Java/hardware/tools/avr/bin
    elif [ $USERAPPSEARCH ]; then
        APPEND_PATH=$APPEND_PATH:$HOME/Applications/Arduino.app/Contents/Java/hardware/tools/avr/bin
    fi
    ### Add All VMware Fusion binaries if VMware.app exit
    ### VMware v11.1 on macos 10.14.5 create com.vmware.fusion.public file on /etc/path.d folder.
    ### This one append /Users/bzz/Applications/VMware Fusion.app/Contents/Public to $PATH
    ### VMware Fusion.app/Contents/Library/Initialize VMware Fusion.tool:   #    pathFile="$PATHSD_DIR"/com.vmware.fusion.public
    ### VMware Fusion.app//Contents/Library/services/services.sh:   #    PUBLIC_PATH_FILE="$PATHSD_DIR"/com.vmware.fusion.public
    local SYSAPPSEARCH=$(ls /Applications 2>/dev/null | grep "VMware Fusion.app")
    local SYSAPPUTISEARCH=$(ls /Applications/Utilities 2>/dev/null | grep "VMware Fusion.app")
    local USERAPPSEARCH=$(ls $HOME/Applications 2>/dev/null | grep "VMware Fusion.app")
    if [ $SYSAPPSEARCH ]; then
        APPEND_PATH=$APPEND_PATH:/Applications/VMware\ Fusion.app/Contents/Library
    elif [ $SYSAPPUTISEARCH ]; then
        APPEND_PATH=$APPEND_PATH:/Applications/Utilities/VMware\ Fusion.app/Contents/Library
    elif [ $USERAPPSEARCH ]; then
        APPEND_PATH=$APPEND_PATH:$HOME/Applications/VMware\ Fusion.app/Contents/Library
    fi
    unset SYSAPPSEARCH  USERAPPSEARCH SYSAPPUTISEARCH

fi
### ##END [[ "$OSTYPE" =~ ^(darwin)+ ]]


#### For /usr/local, if present
if [[ -d /usr/local/sbin ]]; then
    APPEND_PATH=/usr/local/sbin:$APPEND_PATH
fi

#### For /usr/local, if present
if [[ -d /usr/local/bin ]]; then
    APPEND_PATH=/usr/local/bin:$APPEND_PATH
fi

#### For /usr/local/xtal, if present
if [[ -d /usr/local/xtal/bin ]]; then
    APPEND_PATH=$APPEND_PATH:/usr/local/xtal/bin
fi

#### For user's own bin directory, if present
if [[ -d ~/bin ]]; then
    APPEND_PATH=$APPEND_PATH:$HOME/bin
fi

#### For user's own hidden bin directory, if present
if [[ -d ~/.bin ]]; then
    APPEND_PATH=$APPEND_PATH:$HOME/.bin
fi

#### ZAEMONSH bin folder
if [[ -d $ZDOT/bin ]]; then
    APPEND_PATH=$APPEND_PATH:$ZDOT/bin
    # --------------------------------
    #                                 \
    # ---------------------------------
    #         ZEAMONSHCORE_DEBUG       |
    # ---------------------------------
    # uncomment for debugging
    zshrc_primary_load_status  "Bin zeamonsh environnement are now set."
fi
###############################################################################
# Append current directory at the very end of the path, not the beginning.
# Some people consider this to be a minor security hazard.  Putting it at the
# end of the path minimizes the potential hazard.  Uncomment it if this
# what you want.
# APPEND_PATH=$APPEND_PATH:.
# Now assemble and generate the ordered PATH:
#PATH=$PREPEND_PATH:$MIN_PATH:$APPEND_PATH
PATH=$PREPEND_PATH:$MIN_PATH:$PATH:$APPEND_PATH
# Remove any instances of multiple colons:
PATH=${PATH/::/:}
PATH=${PATH/::/:}
PATH=${PATH/::/:}
PATH=${PATH/::/:}
PATH=${PATH/::/:}
PATH=${PATH/::/:}
PATH=${PATH/::/:}
PATH=${PATH/::/:}
# Remove leading : if present
PATH=${PATH#:}
#
# Export PATH as separate command to avoid dollar signs in export line
#
export PATH
#
#
# Avoid repeats in the path
#
typeset -U path

#
# Don't kill background jobs upon logging out
#
setopt nohup

###############################################################################
###############################################################################
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                        ADD MAN PAGES TO $MANPATH                                |
# --------------------------------------------------------------------------------
# Add /usr/local manpages
# if [[ -x $(which manpath ) ]];then
if [[ -x $(whence manpath ) ]];then
    if [[ -f /etc/man_db.conf ]]; then
        return 1
    elif [[ -z $MANPATH ]]; then
    	MANPATH=$( manpath )
    else
        MANPATH=$( manpath ):${MANPATH}
    	typeset -U manpath
    fi
fi

if [[ -d /usr/local/share/man ]];then
    MANPATH=$MANPATH:/usr/local/share/man
fi

if [[ -d /usr/local/man ]];then
    MANPATH=$MANPATH:/usr/local/man
fi

# Add /opt/local/man for Darwinports
if [[ -d /opt/local/man ]]; then
    MANPATH=$MANPATH:/opt/local/man
fi
# Man For XQuartz, if present
if [[ -d /opt/X11/bin ]]; then
    APPEND_PATH=/opt/X11/share/man:$APPEND_PATH
fi

## Homebrew
if [[ -d /usr/local/Homebrew/manpages ]]; then
    MANPATH=$MANPATH:/usr/local/Homebrew/manpages
fi

#Activate zsh-templates man pages
if [[ -d $ZDOT/man ]];then
   MANPATH=$ZDOT/man:$MANPATH
elif [[ -d $ZDOT_TEMPLATE/man ]];then
   MANPATH=$MANPATH:$ZDOT_TEMPLATE/man
fi

# echo $DB
export MANPATH
typeset -U manpath

###############################################################################
###############################################################################
# ------------------------------------------------------------------------------
#                                                                               \
# --------------------------------------------------------------------------------
#                               ADD HELPDIR                                       |
# --------------------------------------------------------------------------------
if [[ -d /usr/share/zsh/$ZSH_VERSION/Help ]];then
  if [[ -z $HELPDIR ]];then
    HELPDIR=/usr/share/zsh/$ZSH_VERSION/Help
  else
    HELPDIR=/usr/share/zsh/$ZSH_VERSION/Help:$HELPDIR
  fi
elif [[ -d /usr/share/zsh/$ZSH_VERSION/help ]];then
  if [[ -z $HELPDIR ]];then
    HELPDIR=/usr/share/zsh/$ZSH_VERSION/help
  else
    HELPDIR=/usr/share/zsh/$ZSH_VERSION/help:$HELPDIR
  fi
elif [[ -d $SWPREFIX/share/zsh/$ZSH_VERSION/Help ]];then

  if [[ -z $HELPDIR ]];then
    HELPDIR=$SWPREFIX/share/zsh/$ZSH_VERSION/Help
  else
    HELPDIR=$SWPREFIX/share/zsh/$ZSH_VERSION/Help:$HELPDIR
  fi
elif [[ -d $SWPREFIX/share/zsh/$ZSH_VERSION/help ]];then

  if [[ -z $HELPDIR ]];then
    HELPDIR=$SWPREFIX/share/zsh/$ZSH_VERSION/help
  else
    HELPDIR=$SWPREFIX/share/zsh/$ZSH_VERSION/help:$HELPDIR
  fi
fi
export -TU HELPDIR helpdir
typeset -U helpdir  # probably redundant with previous line

# --------------------------------
#                                 \
# ---------------------------------
#         ZEAMONSHCORE_DEBUG       |
# ---------------------------------
zshrc_primary_load_status "Path environment set."

