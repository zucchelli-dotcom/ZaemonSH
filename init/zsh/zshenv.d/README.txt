##########################################################################################
#                                                                                        #
#  ZaemonSH created by :                                                                 #
#  Zucchelli Bryan && @N@TOME && Admiral Gr@ss H0pper on Oct 13, 2016.                   #
#  Copyright (c) 2020. All rights reserved.                                              #
#  Inspired by zsh-templates-osx created by :                                            #
#  William Scott on May 11, 2007.                                                        #
#  Copyright (c) 2007. All rights reserved.                                              #
#                                                                                        #
#  This program is free software; you can redistribute it and/or modify it under         #
#  the terms of the GNU General Public License as published by the Free Software         #
#  Foundation; either version 2 of the License, or (at your option) any later version.   #
#                                                                                        #
#  This program is distributed in the hope that it will be useful, but WITHOUT           #
#  ANY WARRANTY ; without even the implied warranty of MERCHANTABILITY or                #
#  FITNESS FOR A PARTICULAR PURPOSE.                                                     #
#  See the GNU General Public License for more details.                                  #
#                                                                                        #
#  You should have received a copy of the GNU General Public License                     #
#  along with this program ; if not, write to the Free Software Foundation,              #
#  Inc., 51 Franklin Street, Fifth Floor, Boston,  MA 02110-1301 USA                     #
#                                                                                        #
#  cf. URL:   http://www.fsf.org/licensing/licenses/gpl.html                             #
#                                                                                        #
##########################################################################################

Any file placed inside this directory will be sourced in
alphabetical order from /etc/zshenv
and will therefore have its contents made available in both
interactive and non-interactive sessions. In other words,
even starting a shell with zsh -f will not prevent the contents
from being sourced. Hence, use considerable care when placing
anything in this directory.

Files with the string "disabled" anywhere in the filename will
be omitted.

To enable a file named foo.disabled, rename it to foo .
