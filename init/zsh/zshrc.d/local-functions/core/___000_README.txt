##########################################################################################
#                                                                                        #
#  ZaemonSH created by :                                                                 #
#  Zucchelli Bryan && @N@TOME && Admiral Gr@ss H0pper on Oct 13, 2016.                   #
#  Copyright (c) 2019. All rights reserved.                                              #
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

#----------------------------------------------------------------------------------------#
#                                     DESCRIPTION
#----------------------------------------------------------------------------------------#
# $ZDOT/zshrc.d/local-functions/core/README.txt
# This is the folder where reside all ZAEMONSH CORE FUNCTIONS wich are the health of ZAEMONSH.
# If you don't know what are you doing, don't touch functions located in that folder !
# This folder is divided into 3 sub-folders : LINUX, OSX, UNIVERSAL :
# All sub-folders functions, for security reason are symlinked in core folder.

#----------------------------------------------------------------------------------------#
#                                        TODO
#----------------------------------------------------------------------------------------#
# 24/10/2017 :
# •• GENERAL :
# 	• Standardize Banner
#   • Problem with cd B(ureau) give >>> ls: impossible d'accéder à '/Users': No such file or directory.
#     cause by _users completion which is only for osx. ---> Give indication that not only function but
#     completion too need to be defined and loaded by categories.
# •• LINUX :
# 	• Problem with configuration files, this message appear.
#	 	>> Path environnement.
# 			manpath: attention : la variable $MANPATH est positionnée, /etc/man_db.conf est ignoré.
# 	• Update Z_FunctionUtil.



#----------------------------------------------------------------------------------------#
#                                       CHANGES
#----------------------------------------------------------------------------------------#
# 02/10/2017 :
# • Add this README file.

# 02/10/2017 to 07/10/2017 :
# • Remove non-core functions and dependant completion to the right place.
#   _docker _docker-machine _docker-compose _insert_kept _expand_word_and_keep
#   _brew _port _cask _quit quit quit_app _get_running_apps _shutdown
#   Z_CleanOSXSHIT godir edit _edit _comp_appgetter _srm _xattr _watch
#	open Z_Sudo_open _init_open _init_open_tiger quit quit_app gem mdattr mlocate
#	Z_Selectfile sudo_fct Z_Testsplit
# • Correct some core buggy scripts.

# 10/10/2017 :
# • Unify script presentation,
# • Correctly remane functions.

# 21/10/2017 :
# • Test on linux. Many problems found !
# • Local command variables are not portable. Better solution is to make a portable function binaryPath.
#   whereis command give that type of result :
#    - on linux : ls: /usr/bin/ls /usr/share/man/man1p/ls.1p.gz /usr/share/man/man1/ls.1.gz
#	 - on osx : /usr/bin/ls
#	So i remove all past defined local command variable. (funcky work!!)
# • Script presentation done for all ZaemonSH core functions.
# • # >> Main aliases. /home/bzs/.init/zsh/zshrc.d/020_aliases.main.zsh:71: command not found: grep --color=auto

# 23/10/2017 :
# • Clean Z_Backup and InstallZaemonSH.zsh

# 24/10/2017 :
# • Add switch_prompt_zenity to linux and update InstallZaemonSH.zsh.
# • Problem on linux with cd B(ureau) give >>> ls: impossible d'accéder à '/Users': No such file or directory.
#   cause by _users completion which is only for osx.
# • Move _setopt _users _setopt to universal

# 17/11/2017 :
# • Partially finished Z_FunctiownUtil.

