##########################################################################
#			   [------[[LINUX FILE COMMANDS]]------]
##########################################################################
#=========================================================================
# 					    ||||FILE INFOS||||
#=========================================================================
#-------------------------------------------------------------------------
#     					      |FILE|
#-------------------------------------------------------------------------
#> file [FILE]  # Afficher le type et les metadata du fichier.
#-------------------------------------------------------------------------
#     					       |LS|
#-------------------------------------------------------------------------
#> ls -lh [FILE] | awk {'print $5'} # Affiche la taille d'un fichier 
									# de façon lisible.
#> ls -d1 $PWD/*   # Affiche le path complet des fichiers.

#> ls ${PATH//:/ } # Afficher toutes les commandes présentent sur le $
				   # système.

#> ls -Sh **/*(.Lm+100) | tail -5  # Trouver les 5 plus gros fichier.				
#-------------------------------------------------------------------------
#     					       |DU|
#-------------------------------------------------------------------------
#> du [FILE] | awk {'print $1'} # Affiche la taille d'un fichier 
								# de façon lisible.							

#> while true; do du -s <file_or_directory>; sleep <time_interval>; done
# Contrôler continuellement la taille d'un fichier/répertoire.
#=========================================================================
# 				    ||||FILE/STRING SEARCH||||
#=========================================================================
#-------------------------------------------------------------------------
#     					      |GREP|
#-------------------------------------------------------------------------
#> grep -i "fauve" [FILE]  # Chercher un mot dans un fichier.

#> grep -RnisI <pattern> *  # Chercher un pattern dans tous les fichiers 
							# du répertoire.

#> grep -A 3 -i "fauve" [FILE]  # Afficher la ligne qui contient le mot et 
							    # les 3 lignes suivantes. 

#> grep -r "fauve" *  # Chercher un mot dans tous les fichiers

#> grep -rl oldstring . |xargs sed -i -e 's/oldstring/newstring/' 
# Chercher recursivement et remplacement oldstring vers newstring dans  
# un fichier.
					  # de façon récursive.
#> ff() { local IFS='|'; grep -rinE "$*" . ; } # Recherche de contenu.       
#-------------------------------------------------------------------------
#     					      |FIND|
#-------------------------------------------------------------------------
#> find . -type l ! -exec test -e {} \; -print # Trouver
 les liens cassés.

#> find [PATH] -newermt "Jan 1" # Trouver les fichiers modifié depuis
								# une date spécifique.

#> find -iname "MyProgram.c"  # Trouver un fichier en utilisant son nom.

#> find -iname "MyProgram.c -exec md5sum {} \;"  
# Exécuter une commande  à partir des fichiers  trouvés par find.

#> find / -name *.jpg -type f -print | xargs tar -cvzf images.tar.gz
# Trouver tous les fichiers jpg dans le système et les archiver.

#> find . -type f | awk -F'.' '{print $NF}' | sort| uniq -c | sort -g
# Lister toutes les extensions dans un répertoire. 

#> find . -type d -empty -delete
#> find . -depth -type d -empty -exec rmdir -v {} \;  
# Trouver les répertoire vides et les éffacer.

#> find . -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate
# Trouver les doublons.

#> find / \( -perm -4000 -o -perm -2000 \) –print 
# To find SUID and SGID  files on the system, use the following command:
# SUID or SGID bits safely disabled (using chmod -s filename) 
# unless required for other program.

#> find . -type f -delete  # Effacer tous les fichiers, pas les dossiers.

#> find . -type d -delete  # Effacer tous les dossiers.

#> find . -type d -not -name A -exec rm -rf {} \; # Effacer tous dossiers, sauf [A] 

#> find . -type f -not \( -name '*zip' -or -name '*iso' \) -delete 
# Effacer tous les fichiers hormis les zip et les iso.								

#> find ~/sources/ -type f -not -name '*.php' -delete
#> find ~/sources/ -type f -not -name '*.php' -print0 | xargs -0 -I {} rm -v {}
# Effacer tous les fichiers hormis les php.

#> find . -type d -maxdepth 1 -not -name A -exec rm -ir {} \;
# Effacer tous les sous répertoire sauf 1, ici [A].

#> find -iname '*.htm' | while read f; do echo mv \"$f\" \"${f/.htm/.html}\"; done 
# Renommer les fichiers .htm en .html

#> find -name *.\[c\|h\] | xargs wc -l # Afficher le nombre de ligne.

#> find ./ $1 -name "* *" | while read a ; do mv "${a}" "${a//\ /_}" ; done
# Rennmer tous les fichiers dans le répertoire actuel en effacant les
# espaces.
#-------------------------------------------------------------------------
#     					      |XARGS|
#-------------------------------------------------------------------------
#> ls *.jpg | xargs -n1 -i cp {} [/external-hard-drive/directory] 
# Copy All jpg image to external drive.											


#=========================================================================
# 				   ||||FILE/STRING MANIPULATION||||
#=========================================================================
#-------------------------------------------------------------------------
#     						    |TR|
#-------------------------------------------------------------------------
#> tr '[:lower:]' '[:upper:]' <[TEXT] >[TEXTUPPER] 
# Convertir tout le texte en majuscule.
#> tr '[:upper:]' '[:lower:]' <[TEXT] >[TEXTUPPERLOWER] 
# Convertir tout le texte en minfuscule.												   
#-------------------------------------------------------------------------
#     						   |ECHO|
#-------------------------------------------------------------------------
#> var=:foobar:; echo ${var:1:-1}  # Retirer le premier et dernier caratére
								   # d'une phrase.
#-------------------------------------------------------------------------
#     						   |TOUCH|
#-------------------------------------------------------------------------
#> touch {1..10}.text # Créer plusieurs fichiers d'un coup.
#-------------------------------------------------------------------------
#     						   |TAIL|
#-------------------------------------------------------------------------
#> cat /dev/null > [FILE]  # Vider un fichier.

#> tail [FILE]  # Afficher les 10 dernieres lignes.

#> tail -n N [FILE] # Afficher N lignes du fichier.

#> tail -f [LOGFILE] # Afficher un fichier en temps réel.
#-------------------------------------------------------------------------
#     						   |SED|
#-------------------------------------------------------------------------
#> s="124890";for i in $(seq 0 1 $((${#s}-1))); do arr[$i]=${s:$i:1}; done
# Transforme une phrase en un tableau.

#> sed -i 's/ /-/g' * # Remplacer les espaces par des tirets dans un fichier.

#> sed -n 5p <file>  # Afficher une ligne sécifique d'une ligne.

#> sed -n '10,20p' <filename> # Afficher toutes les lignes entes la 10em
							  # et la 20em ligne du fichier
#> sed -n 's/.*<title>\(.*\)<\/title>.*/\1/ip;T;q' file.html 
# Extraire les titres d'une page web.
##########
#
#> MOT=ABCD
#> echo ABCD | sed s'/.$//' # Supprimer le dernier caractére d'un mot.

#> echo ABCD | sed s'/[a-zA-Z]$//'  # Supprimer le dernier caractère 
									# d'un mot si il est dans l'alphabet.

#> echo $MOT | sed 's/^.//' # Supprimer le premier caractère d'un mot.
						 # sed 's/trouve/remplace/' fichier
## Meme chose avec la subtitution de variable :
#> echo ${MOT/%?/} ou ${MOT%?}  # Supprimer le dernier caractére d'un mot.
#> echo ${MOT/#?/} ou ${MOT#?}  # Supprimer le premier caractère d'un mot. 	
#
##########
##########
#
#> cat fichier

#> sed 's/a//' fichier  # Supprime le caractère a dans fichier.

#> sed 's/^.//' fichier # Supprime premier caractère sur toutes les lignes.

#> sed 's/.$//' fichier  # Supprime dernier caractère sur toutes les lignes

#> sed 's/.//;s/.$//' fichier # Supprime premier et dernier caractère sur 
							  # toutes les lignes.
#> sed 's/^F//' fichier       # Supprime le premier caractére sur les lignes
 							  # uniquement si un caractère spécifique est 
		 					  # trouvé, ici F.                 							  
#> sed 's/x$//' fichier       # Supprime le dernier caractére sur les lignes
							  # uniquement si un caractère spécifique est 
							  # trouvé, ici x.
							   
#> sed 's/...//' fichier  # Retire les 3 premiers caractères de toutes 
						  # les lignes.

#> sed -r 's/.{4}//' fichier # Supprime les n premiers caractères de toutes
						     # les lignes, ici n=4.

#> sed -r 's/(.{3}).*/\1/' fichier # Supprime les n derniers caractéres dev 										   # toutes les lignes, ici n=3.

#> sed -r 's/(.{3}).*/\1/' fichier # Supprime tout, mis-à-part un nombre
								   # n de premiers caractères sur toutes 
	 							   # les lignes, ici n=3.	 							  							   
#> sed -r 's/.*(.{3})/\1/' fichier # Supprime tout, mis-à-part un nombre
		 						   # n de derniers caractères sur toutes 
								   # les lignes, ici n=3.

#> sed 's/[aoe]//g' fichier  # Supprime plusieur caractéres définit,
				     		 # ici aoe,sur toutes les lignes.

#> sed 's/lari//g' fichier   # Supprime un pattern prééfinit, ici lari. 
 

#> sed 's/u//2' fichier	 # Supprime un nombre définit d'occurences  
						 # du patterns prédéfinit, ici 2u, sur 
					 	 # toutes les lignes.


#> sed 's/a.*//'  # Supprime sur toutes les lignes, ce qui suit un 
				  # caractère, ici a.

#> sed sed 's/[a-z]//g' fichier # Supprime toutes les minuscules sur
				 				# toutes les lignes du fichier.

#> sed 's/[^a-z]//g' fichier  # Supprime toutes les majuscules sur
							  # toutes les lignes du fichier.


#> sed 's/[uU]//g' fichier  # Supprime toutes les occurences
# 							# majuscules, minuscules; ici u et U
#  							# sur toutes les lignes.						
##########
##########
#
#> sed 's/[0-9]//g' fichier # Supprime sur toutes les lignes, 							
							# tous les points.

#> sed 's/[a-zA-Z0-9]//g' fichier  # Supprime tous les caractères alpha-
								   # numériques, sur toutes les lignes 
								   # d'un fichier.
#> sed '/./=' fichier 'N; s/\n/ /' # Ajoute un nombre à toutes les lignes
#							 	   # non vides.

sed 's/#*//' #Supprime toutes les lignes qui commence par #.
sed 's/_*//' #Supprime toutes les lignes qui commence par _.

##########
#-------------------------------------------------------------------------
#     						   |MV|
#-------------------------------------------------------------------------
#-------------------------------------------------------------------------
#     						   |CP|
#-------------------------------------------------------------------------
#> cp foo{,bak} # Copie rapide.
#-------------------------------------------------------------------------
#     						  |RENAME|
#-------------------------------------------------------------------------
#> rename 's/^/prefix/' * # Renommer en ajoutant un préfix.
#-------------------------------------------------------------------------
#     						   |RM|
#-------------------------------------------------------------------------
#> rm -r.??*   # Effacer tous les fichiers cachés dans un répertoire.

#> rm -R `ls | egrep -v 'dir1|dir2|file1'` # Effacer tous les fichiers et répertoires
										   # hormis les répertoires [dir1] [dir2] 
										   # [dir3]
#-------------------------------------------------------------------------
#     						   |AWK|
#-------------------------------------------------------------------------
#> awk -F ':' '$3==$4' passwd.txt # Afficher toutes les lignes contenant
								   # le meme UID et GID.
#> awk '/[STARTPATTERN]/,/[STOPPATTERN]/' [FILE] # montre une partie de texte

#> awk '!/[PATTERN1]|[PATTERN1]/' [FILE] # Supprime toutes les lignes qui
										 # Contienne l'un ou l'autre des
								         # [PATTERN].
#> awk '!x[$0]++' [FILE]  # Supprime les entrées similaires.

#> awk '{$1=$3=""}1' [FILE] # Exclure plusieurs colonnes.


#========================================================================
# 				     ||||FILE COMPARAISON||||
#=========================================================================
#-------------------------------------------------------------------------
#     						  |DIFF|
#-------------------------------------------------------------------------
#> diff -w [FILE1] [FILE2]  # Différence entre deux fichiers, en ignorant
							# les blancs.
#> diff <(tail -10 file1) <(tail -10 file2)  # Différence entre 2 résultats
											 # de commande. 
#> diff <(sort file1) <(sort file2) #  diff two unsorted files without creating 										#  temporary files								 
#> diff <(lsof -p 1234) <(sleep 10; lsof -p 1234) 
# Différence entre le résultat de deux commandes.

#> diff <(echo "$a") <(echo "$b")  # Différence entre deux variables




##########################################################################
#		      [-----[[LINUX DAILY USE COMMANDS]]-----]
##########################################################################
#=========================================================================
# 					  |||| COMPRESSION ||||
#=========================================================================
#-------------------------------------------------------------------------
#     						   |TAR|
#-------------------------------------------------------------------------
#> tar -cvf [DIR/FILNENAME].tar.gz [DIR/FILNENAME]  # Compress 
													# [file/directory]

#> tar -cvf /path/dir.tar /path/dir* --exclude "/path/dir/name" --exclude "/path/dir/opt"  # Compresser en excluant des répertoires.

#> tar -cavvf [DIR/FILNENAME].xz [DIR/FILNENAME	# Avec options: -a, 
												# possibilité de choisir
												# l'extension.												 
#> tar -xvf [DIR/FILNENAME].tar.gz  # Decompress [file/directory.


#> tar -tvf archive.tar # Lister le contenu d'une archive tar.
#-------------------------------------------------------------------------
#     						   |GZIP|
#-------------------------------------------------------------------------
#> gzip [FILE]  # Compress.

#> gzip -9 [FILE] # Etablir le ratio de compressions. 
				  # 1 the lowest,but fastest.
				  # 9 is the best but slowest.
#> gzip -d [FILE].gz  # Decompresse
#> gunzip [FILE].gz

#> gzip -l [FILE].gz  # Montre le ratio de compression.

#> zcat [FILE].gz # Voir le contenu d'un gzip.
#-------------------------------------------------------------------------
#     						   |BZIP2|
#-------------------------------------------------------------------------
#> bzip2 [FILE]  # Compresse

#> bzip2 -d [FILE]  # Decompresse
#-------------------------------------------------------------------------
#     						    |ZIP|
#-------------------------------------------------------------------------
#> zip [FILE].zip [FILE] # Compresse

#> zip -r [ARHIVE].zip [FOLDER1] [FILE2] # Compresse directory

#> zip [ARHIVE].zip -u newfile  # Ajouter à l'archive.

#> zip -d arc.zip file.txt # Supprimer un fichier de l'archive.

#> unzip [FILE] # Decompresse

#> unzip -l [FILE].zip  # Voir le contenu d'un zip
#-------------------------------------------------------------------------
#     						 |SQUASHFS|
#-------------------------------------------------------------------------
#> sudo mksquashfs /etc test.squashfs # Créer une archive squashfs 

#> sudo mksquashfs /etc test.squashfs -e /etc/passwd /etc/shadow 
# Meme chose en excluant les fichiers passwd and shadow de l'archive. 

#> mkdir /mnt/squahfs && mount -o loop ompressedfs.squashfs /mnt/squash 
# Pour Monter l'archive squahfs et copier des éléments de son contenu.


#=========================================================================
#					 |||| NETWORK COMMANDS ||||
#=========================================================================
#-------------------------------------------------------------------------
#     						   |CURL|
#-------------------------------------------------------------------------
#> echo $(curl '[URL]') 
#> printf "%s" $(curl 'file:/home/bz13/Bureau/android.html') # View page source.

#> curl _O '[FILEURL]'  # Download file.

#> curl -L -O -C - [URL] # Résumé un téléchargement.

#> curl -sm1 [URL] | grep -o 'http://[^"]*jpg' | sort -u | wget -qT1 -i-
# Télécharger tous les jpg d'une page.

#> curl -u username --silent "https://mail.google.com/mail/feed/atom" | perl -ne 'print "\t" if /<name>/; print "$2\n" if /<(title|name)>(.*)<\/\1>/;'
# Signaler les messages gmail non lus.
#-------------------------------------------------------------------------
#     						   |WGET|
#-------------------------------------------------------------------------
#> wget -m '[URL]'  # Faire un mirroir entier d'un site.

#> wget -O - [URL] | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'
# Extract All URL in html file 

#> cat url-list.txt | xargs wget –c # Télécharger toutes les sites mentionnés
									# dans un fichier txt
#> wget -c -r -l1 -R wav,iso,dmg [URL] # résumable, récursif, 1er niveau, 
									   # fichiers wav,iso,dmg exclus.

#> wget -r -l1 -H -nd -A mp3 -e robots=off http://example/url						
# Copier tous les mp3 d'un site.


#> wget -r -l1 -H -t1 -nd -N -np -A "*.mp3" -erobots=off -i mp3_sites.txt
# Télécharge de façon récursive tous les mp3, renvoyés par la liste d'url
# contenu dans le fichier mp3_sites.txt,qui sont nouveaux vis-à-vis de
# ceux déjà téléchargés.

#> wget -q -O - `youtube-dl -b -g $url`| ffmpeg -i - -f mp3 -vn -acodec libmp3lame -| mpg123  -  # Jouer un mp3 depuis youtube sans le télécharger.

# Google Translate
translate(){ wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/'; }
#-------------------------------------------------------------------------
#     						   |LYNX|
#-------------------------------------------------------------------------
lynx -dump http://www.domain.com | awk '/http/{print $2}'
#> lynx -dump -listonly [URL]  # Extraire les liens d'une page web.

#> mp3=$(lynx -dump [URL] | grep 'http://' | awk '/mp3/{print $2}')
&& for i in $mp3;do wget $i; done # Download all mp3.

#> lynx -dump -head http://www.example.com/  # Dump html header.

#> lynx -accept_all_cookies -cmd_script=/your/keystroke-file  # automatiser le surf.
#-------------------------------------------------------------------------
#     						   |FTP|
#-------------------------------------------------------------------------
#-------------------------------------------------------------------------
#     						   |SSH|
#-------------------------------------------------------------------------
#> sshfs name@server:/path/to/folder /path/to/mount/point 
# Monter un dossier/systeme à travers ssh

#> ssh -N -L2001:localhost:80 somemachine  # Démarrer un tunnel de [MACHINE1]:8O
										   # à machine.

#> ssh -t remote_host screen -r # Connecter un écran à travers ssh.

#> dd if=/dev/dsp | ssh -c arcfour -C username@host dd of=/dev/ds					   
# Brancher la sortie du microphone vers les enceintes d'un ordinateur distant.

#> ssh user@host "tar -zcf - /path/to/dir" > dir.tar.gz  
# Créer une archive local d'un répertoire distant.

#> ssh  -t remotebox "tail -f /var/log/remote.log" # tail fichier log à travers SSh.

#>  ssh-keygen; ssh-copy-id user@host; ssh user@host 
# Transférer une clés publique vers une autre machine. 
#-------------------------------------------------------------------------
#     						   |SCP|
#-------------------------------------------------------------------------
#-------------------------------------------------------------------------
#     						   |RSYNC|
#------------------------------------------------------------------------
#> rsync --progress --partial --rsh="ssh -p 8322" --bwlimit=100 --ipv4 user@domain.com:~/file.tgz .
# Replace scp y rsync.

#> rsync -rv <src> <dst> --progress  # Copier avec bar de progrès.



#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#			  [[-----[[LINUX SYSTEM COMMANDS]]-----]]
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#=========================================================================
#					   |||| SYSTEM INFOS ||||
#=========================================================================
#-------------------------------------------------------------------------
#     					      |GETCONF|
#-------------------------------------------------------------------------
# getconf LONG_BIT  # Pour voir si le système est 32 ou 64 bits
#-------------------------------------------------------------------------
#     					       |UNAME|
#-------------------------------------------------------------------------
#> uname -a # Montre informations importantes sur le système.
#-------------------------------------------------------------------------
#     					       |DMESG|
#-------------------------------------------------------------------------
#> dmesg -T|sed -e 's|\(^.*'`date +%Y`']\)\(.*\)|\x1b[0;34m\1\x1b[0m - \2|g'
# dmesg avec date en couleur.
#-------------------------------------------------------------------------
#     					       |LSPCI|
#-------------------------------------------------------------------------
#> lspci   # Lister les informations sur les bus pci et les appareils
		   # connectés au bus.  
#-------------------------------------------------------------------------
#     					       |ECHO|
#-------------------------------------------------------------------------
#> echo $0  # Affiche le terminal actif.

#> echo $PATH | tr \: \\n  # Afficher les répertoires du PATH ligne par 
						   # ligne.
#-------------------------------------------------------------------------
#     					        |LS|
#------------------------------------------------------------------------- 
#> ls -lct /etc | tail -1 | awk '{print $6, $7}'  # Affiche depuis quand est
											   # installé le système.
#-------------------------------------------------------------------------
#     					       |EGREP|
#------------------------------------------------------------------------- 
#> egrep -i " connected|card detect|primary dev" /var/log/Xorg.0.log
# Identifier le driver video utilisé par Xorg.
=========================================================================
#					   |||| ADMIN COMMANDS ||||
#=========================================================================
#-------------------------------------------------------------------------
#     						  |SYSCTL|
#------------------------------------------------------------------------
#> sysctl -w vm.drop_caches=3   # Nettoyer le cache mémoire du sytème.
#-------------------------------------------------------------------------
#     						   |MKFS|
#-------------------------------------------------------------------------
#> mkfs -t ext3 -L sys_data /dev/sda5  # créer un système de fichier en ext3, 
									   # ayant pour label « sys_data »
#> mkfs.vfat /dev/sdc1 # formatter en fat, utile pour les clés USB.
#-------------------------------------------------------------------------
#     						   |DATE|
#-------------------------------------------------------------------------
#> date -s "01/31/2015 23:59:53"  #  Configurer la date.

#> date -d @1234567890  # Convertir unixtime to human-readable. 

#> buf () { cp $1{,$(date +%Y%m%d_%H%M%S)}; }  # backup de fichier daté.
#-------------------------------------------------------------------------
#     						 |SHUTDOWN|
#-------------------------------------------------------------------------
#> sudo shutdown -h +10  # Eteindre le systeme après 10 minutes.

#> sudo shutdown -Fr now  # Forcer la vérification du système au reboot.
#-------------------------------------------------------------------------
#     					    |NOTIFY_SEND|
#-------------------------------------------------------------------------
#> notify-send "TITRE" "Corps de texte." # Envoyer une notification.


#=========================================================================
#					   |||| SYSTEMV COMMANDS ||||
#=========================================================================
#-------------------------------------------------------------------------
#     					      |CHKCONFIG|
#-------------------------------------------------------------------------
#> chkconfig --list     
#> ls /etc/rc.d/init.d/ 
#> sudo initctl list | grep running  # Affiche les services avec leur
									 # status.

#> chkconfig [SERVICENAME] # Donne le status du service.

#> chkconfig [SERVICENAME] on/off # Activer le service au reboot
								  # persistent 

#> chkconfig [SERVICENAME] --add  # Utilisé à la création d'un nouveau 
								  # service ou après modifications.
#-------------------------------------------------------------------------
#     						   |SERVICE|
#-------------------------------------------------------------------------
#> service [SERVICENAME] status # Avoir le status du service.

#> service --status-all # Avoir le status de tous les services.

#> service [SERVICENAME] start/stop  # Démarrer/stopper un service.

#> service [SERVICENAME] restart/reload  # stoppe et démarre le service 
										 # ou réinitialise le service sans 
										 # stopper les opérations en cours.


#=========================================================================
#					     |||| SYSTEMD COMMANDS ||||
#=========================================================================
#-------------------------------------------------------------------------
#     						    |SYSTEMCTL|
#-------------------------------------------------------------------------
#> systemctl list-units --all -t service  
#> ls /lib/systemd/system/*.service        # Liste tous les services.

#> systemctl list-dependencies [SERVICENAME].service  # Lister les dépendances 
													  # d'un service.

#> systemctl status [SERVICENAME].service  # Avoir le status du service.

#> systemctl start/stop [SERVICENAME].service # Démarrer/stopper un service.
											  # non-persistent 
											  # au redemmarage.
#> systemctl restart/reload [SERVICENAME].service # stoppe et démarre le service
										 		  # réinitialise le service  
										          # sans stopper les opérations
										          # en cours.
#> systemctl enable/disable [SERVICENAME].service # Activer le service au reboot
										 		  # persistent.

#> systemctl enable/disable --global [SERVICENAME].service 
# Activer le service au reboot, persistant, configuration globale pour tous les
# utilisateurs futurs.

#> systemctl mask/unmask [SERVICENAME].service  # Lier ces services à /dev/null
												# Brute-force disable. 

#> systemctl daemon-reload  # Utilisé àla création d'un nouveau service ou
							# après modifications. 
#-------------------------------------------------------------------------
#     						 |JOURNALCTL|
#-------------------------------------------------------------------------
#> journalctl --user  # View log as user.
#> journalctl --user --since=today # View log as user from today.


#=========================================================================
#					   |||| PACKAGE MANAGER ||||
#=========================================================================
#-------------------------------------------------------------------------
#     						  |APT-GET|
#-------------------------------------------------------------------------
###MANAGING SOFTWARE---
#> apt-get install [PKG]  # Installer un nouveau paquet depuis le 
						  # répertoire.
#> dpkg -i [LOCALPKGPATH]  # Installer un nouveau paquet localement.

#> apt-get remove [PKG] # Désinstaller un paquet.

###UPDATING SYSTEM---
#> apt-get update  # Mise à jour de la liste des paquets.

#> apt-get upgrade [PKG]  # Mise à jour du  système.

#> apt-get check  # Vérifier toutes les dépendances.

#> apt-get -f install # Corriger les problèmes de dépendance.

###SEARCH PACKAGES---
#> apt-cache search [PKG]  # Chercher un paquet.

#> apt-cache search [PATTERN]  # Chercher un paquet par PATTERN. 

#> apt-file search [FILENAME]  # Chercher un paquet par nom.

#> dpkg -l  # Lister les paquets installés.	 				  

###CONFIGURING REPOSITORIES
#> cat /etc/apt/sources.list  # Lister les repos 
							  # et eventuellement les modifiés.
#-------------------------------------------------------------------------
#     					    |PACMAN/YAOURT|
#-------------------------------------------------------------------------
#  ----------------------
#  |       PACMAN       |
#  ----------------------
###MANAGING SOFTWARE---
#> pacman -S [PKG/GROUP]  # Installer un nouveau paquet depuis le
				          # répertoire.
#> pacman -U [LOCALPKGPATH]  # Installer un nouveau paquet localement.

#> pacman -Sw [PKG] # Télécharger un paquet sans l'installer.

#> pacman -S $(pacman -Qqen) #Reinstall all packages.

#> pacman -R [PKG]  # Désinstaller un paquet.

#> pacman -Rs [PKG]  # Désinstaller un paquet, avec les dépendances.
					 # qui ne sont pas utilisées par d'autres paquet.

#> pacman -Rsc [PKG] # Désinstaller un paquet, avec  toutes les dépendances.
 
#> pacman -Rn package_name  # Désinstaller un paquet, avec les configurations.

#> pacman -Sc  # Retirer les paquet désinstaller du cache > Cache cleaning.

#> pacman -Scc # Retirer tous les paquets du cache.

#> pacman -Rsn $(pacman -Qdtq) # Retirer les packages orphelins du système.

#> find /var/cache/pacman/pkg -not -mtime -7 | sudo xargs rm 
# Effacer les paquets du cache de pacman de plus d'une semaine.
###UPDATING SYSTEM---
#> pacman -Sy  # Mise à jour de la liste des paquets.

#> pacman -Su  # Mise à jour du  système.

#> pacman -Syu # Mise à jour de la liste des paquets et
			   # Mise à jour du  système.

###SEARCH PACKAGES---
#> pacman -Sii # Obtenir des informations détaillées sur un package installé.

#> pacman -Ss [PKG]  # Chercher un paquet.

#> pacman -Ss [PATH]  # Chercher un paquet par PATTERN. 

#> pacman -Qq [FILENAME] # Chercher un paquet par nom. 

#> pacman -Q  # Lister les paquets installés.

#> pacman -Qo /file_path # Trouver à quel paquet appartient un fichier.

#> pacman -Qdt # Lister les paquets orphelins n'ayant pas de dépendances.

#> pactree [PKG]  # Voir les dépendances d'un paquet.

###CONFIGURING REPOSITORIES 
#> cat /etc/pacman.conf  # Lister les repos
					     # et eventuellement les modifiés.

## Editer /etc/pacman.conf              # Ignorer un package
## et ajouter IgnorePkg=package_name	# en mettant le 
										# système à jour.

## Editer /etc/pacman.conf              # Ignorer un groupe de package
## et ajouter IgnorePkg=package_name	# (ex. GNOME) en mettant le 
										# système à jour.							
#  ----------------------
#  |       YAOURT       |
#  ----------------------
#> yaourt -Syua  # Mise à jour du repo officielle et celui de AUR			

#> yaourt -S [PKG] # installer un paquet.


#=========================================================================
#					    |||| USER COMMANDS ||||
#=========================================================================
#-------------------------------------------------------------------------
#     						   |PASSWD|
#-------------------------------------------------------------------------
#> sudo passwd -l root # Disable root user
#> sudo passwd -u root # Enable  rooot user
#-------------------------------------------------------------------------
#     						   |USERADD|
#-------------------------------------------------------------------------
#> useradd -d /home/[USERNAME] -m -r -p jj [USERNAME]  # Créer un 
													   # utilisateur. 
#> useradd -d /home/[USERNAME] -m -s /bin/bash -p $(mkpasswd --hash=SHA-512 password) [USERNAME]
# Créer un nouvel utilisateur avec mot de passe crypter.
#> useradd -g [OLDPRIMARYGROUP] [NEWPRIMARYGROUP] && id
# Changer le groupe d'un utilisateur.
#-------------------------------------------------------------------------
#     						   |USERDEL|
#-------------------------------------------------------------------------
#> userdel -r -f [USERNAME]  # Effacer un utilisateur.
#-------------------------------------------------------------------------
#     						   |USERMOD|
#-------------------------------------------------------------------------
#> usermod -s /usr/sbin/nologin [USERNAME]  # Désactiver un acompte. 
#> usermod -g  [GROUP] [USER]
 #------------------------------------------------------------------------
#     						    |GROUP|
#-------------------------------------------------------------------------
#> chmod --reference file1 file2  # Donner les mêmes permissions à [FILE1]
								  # vers [FILE2]
#-------------------------------------------------------------------------
#     						    |STAT|
#-------------------------------------------------------------------------
#> stat -c '%n %U:%G-%a' *  # Voir le propriétaire, le groupe et les 
							# permissions des composants du répertoire actif.
#-------------------------------------------------------------------------
#     						     |ID|
#-------------------------------------------------------------------------
#> id   # Donne l'UID, le GID  et le groupe de l'utilisateur.
#-------------------------------------------------------------------------
#     						    |NAMEI|
#-------------------------------------------------------------------------
#> namei -m $(pwd)   # Voir les permissions du répertoire actuel
					 # et de tous les répertoires au dessus.
#-------------------------------------------------------------------------
#     						     |PS|
#-------------------------------------------------------------------------
#> ps -eo user | sort -u  # Aficher les utilisateurs normaux et virtuel
						  # du systeme.			


#=========================================================================
#					     |||| DISK COMMANDS ||||
#=========================================================================
#> cat /proc/partitions # Montre les partitions en octal.
#-------------------------------------------------------------------------
#     						    |LSBLK|
#-------------------------------------------------------------------------
#> lsblk  # Voir la tables des points de montage du système.

#> lsblk -do name,model,serial #

#> lsblk -o +UUID # Avec les UUID de disk. 
#-------------------------------------------------------------------------
#     						     |DF|
#-------------------------------------------------------------------------
#> df -h  # Voir la tables des points de montage du système.
#-------------------------------------------------------------------------
#     						     |DD|
#-------------------------------------------------------------------------
#> dd if=[USBMOUNTPATH] | pv | of=dvd.iso bs=4m  # Copier un iso vers usb

#> dd if=/dev/sda of=~/MBR.image bs=512 count=1 
# Créer ume image du master boot record avec table de partition.

#> dd if=/dev/sda3 of=/dev/sdb3 bs=4096 conv=notrunc,noerror
# Copie une partion sur une autre.

#> dd if=/dev/sda1 | gzip -c | split -b 2000m - /mnt/hdc1/backup.img.gz
# Create a gzipped image of a partition using split

#> cat /mnt/hdc1/backup.img.gz.* | gzip -dc | dd of=/dev/sda1 
# Restaurer le backup de la commande pécédente.

#> dd if=/dev/sda of=/dev/null bs=1m # Vérifier la présence de badblock.

#> dd if=/dev/zero of=/dev/null bs=1M count=32768
# Donne la bande passante de la mémoire du processeurs.

#> dd if=/dev/zero of=/dev/sda bs=4k # Ecrire des 0 sur un disque.

#> dd if=/dev/urandom of=/dev/sda bs=4k # Ecrire des données aléatoire
										# sur un disque.

#> dd if=/dev/zero of=/dev/null bs=1M count=32768
# Donne la bande passante de la mémoire du processeurs.
#-------------------------------------------------------------------------
#     						    |MOUNT|
#-------------------------------------------------------------------------
#> cat /etc/fstab # Fichier de configuration des points de montage.

#> mount # Pour la table de montage.

#> mount -t vfat /dev/hda1 /Dos/C/ # Monter un système de fichier DOS

#> mount -t hfsplus -o loop stage1-decrypted.dmg /mnt/dmg  
   # To mount the uncompressed DMG image in linux.

#> dmg2img -i stage2-decrypted.dmg -o stage2-decrypted-uncompressed.img && \
   mount -t hfsplus -o loop stage2-decrypted-uncompressed.dmg /mnt/dmg
   # Mounting the compressed .dmg disk image.(dmg2img is needed).

#> sudo mkdir -p /mnt/[MOUNTPOINT] && mount -o loop [ISO].iso /mnt/[MOUNTPOINT] && \
cd /mnt/[MOUNTPOINT] && ls 
#> mount -t iso9660 -o loop,ro disk1.iso /mnt/disk  # Monter une image iso.
#-------------------------------------------------------------------------
#     						    |UMOUNT|
#-------------------------------------------------------------------------
#> umount [MOUNTPOINTPATH]  # Démonter un disque/partition.
#-------------------------------------------------------------------------
#     					   	   |MKISOFS|
#------------------------------------------------------------------------ 
# To edit bootable ISO mount it as it’s described here, copy it’s contents to some
# directory, edit files you need and generate new ISO :
#>sudo mkisofs -o /tmp/new.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V “new iso name”


#=========================================================================
#					   |||| PROCESS COMMANDS ||||
#=========================================================================
#-------------------------------------------------------------------------
#     							  |TOP|
#-------------------------------------------------------------------------
#> G=$(stty -g);stty rows $((${LINES:-50}/2));top -n1; stty $G;unset G
# TOP en couleur split 4 ways for x seconds.
#-------------------------------------------------------------------------
#     							  |FIND|
#-------------------------------------------------------------------------
#> find /proc -user myuser -maxdepth 1 -type d -mtime +7 -exec basename {} \; | xargs kill -9  # Trouver les processus depuis plus d'une semaine.
#-------------------------------------------------------------------------
#     							  |PS|
#-------------------------------------------------------------------------
#> ps -ef | more  # Voir les processus en cours.

#> ps -efH | more  # Voir les processus en cours, sous forme d'arbre 
				   # généalogique.

#> cd /proc&&ps a -opid=|xargs -I+ sh -c '[[ $PPID -ne + ]]&&echo -e "\n[+]"&&tr -s "\000" " "<+/cmdline&&echo&&tr -s "\000\033" "\nE"<+/environ|sort'
# Voir tous process de commande et leur environnements.

#> ps -auxwww  # ps complet.
#-------------------------------------------------------------------------
#     							  |PKILL|
#-------------------------------------------------------------------------
#> pkill -KILL -u [USERNAME] # Tuer tous mes processus, brute-force logout.

#> pkill -x Firefox # Tuer un processus par nom. 
#-------------------------------------------------------------------------
#     							 |STRACE|
#-------------------------------------------------------------------------
#> straceprocessname(){ x=( $(pgrep "$@") ); [[ ${x[@]} ]] || return 1; strace -vf ${x[@]/#/-p }; }


#=========================================================================
#					     |||| MEMORY COMMANDS ||||
#=========================================================================
#-------------------------------------------------------------------------
#     						  	   |PS|
#-------------------------------------------------------------------------
#> ps axo rss,comm | awk '{sum+=$1; print $1/1024, "MB - ", $2} END {print "\nTotal RAM Used: ", sum/1024, "MB\n"}'   # RAM usage.

#> ps -eo size,pid,user,command --sort -size |awk '{hr[1024**2]="GB";hr[1024]="MB";for (x=1024**3; x>=1024; x/=1024){if ($1>=x){printf ("%-6.2f %s ", $1/x, hr[x]);break}}}{printf ("%-6s %-10s ", $2, $3)}{for (x=4;x<=NF;x++){printf ("%s ",$x)} print ("\n")}'  # Trouver les processus qui utilisent le plus de mémoire
				# et afficher de façon lisible par un humain.

#> TR=`free|grep Mem:|awk '{print $2}'`;ps axo rss,comm,pid|awk -v tr=$TR '{proc_list[$2]+=$1;} END {for (proc in proc_list) {proc_pct=(proc_list[proc]/tr)*100; printf("%d\t%-16s\t%0.2f%\n",proc_list[proc],proc,proc_pct);}}'|sort -n |tail -n 10
# Les 10 processus qui utilisent le plus de mémoire.				
#-------------------------------------------------------------------------
#     						  	   |DD|
#-------------------------------------------------------------------------
#> dd if=/dev/mem of=myRAM bs=1024 # Copy RAM memory to a file

#> sudo dd if=/dev/mem | cat | strings # Montre tous les strings contenu
									   # en RAM.
#-------------------------------------------------------------------------
#     						  	 |MEMINFO|
#-------------------------------------------------------------------------
#> meminfo -h  
#-------------------------------------------------------------------------
#     						  	 |VMSTAT|
#-------------------------------------------------------------------------
#> watch vmstat -sSM  # Monitor memory usage.

#> while [ 1 ]; do echo -n "`date +%F_%T`" ; vmstat 1 2 | tail -1 ; sleep 4; done

#> vmstat 1 | awk '{now=strftime("%Y-%m-%d %T "); print now $0}'
# Vmstat/iostat avec timestamp.


#=========================================================================
#					    |||| ADMIN NETWORK COMMANDS ||||
#=========================================================================
#> 2>|/dev/null dd if=/dev/urandom bs=1 count=6 | od -t x1 | sed '2d;s/^0\+ //;s/ /:/g'
# Génére une adresse MAC aléatoire.
#-------------------------------------------------------------------------
#     					   		   |LSOF|
#-------------------------------------------------------------------------
#> lsof -P -i -n | egrep 'COMMAND|LISTEN|UDP' # Lister les ports ouverts 

#> lsof -r 2 -p PID -i -a  
lsof -P -i -n | cut -f 1 -d " "| uniq | tail -n +2 
# Voir les connections de toutes les appications et utilisateurs en temps réel.

#> lsof -i tcp:80 # Quel programme est en écoute sur le port 80.

#> lsof -c dhcpd  # Lister tous les fichiers ouverts par une applications.

alias oports="echo -e "User:\tCommand:\tPort:\n----------------------------" && lsof -i 4 -P -n | awk '/LISTEN/ {print $3, $1, $9}' | sed 's/ [a-z0-9\.\*]*:/ /' | sort -u -k 3 -n | xargs printf '%-10s %-10s %-10s\n'"
# Fonction pour afficher les process, les port qu'ils ouvrent, et 
# le propiétaire du process.

#> 
#-------------------------------------------------------------------------
#     						     |IFCONFIG|
#-------------------------------------------------------------------------
#> ifconfig -a  # Voir le status de toutes les interfaces.

#> ifconfig eth0 up/down # Démarrer/Stopper une interface spécifique.

#> ifconfig eth0 172.16.25.125 # Configurer adresse ip pour interface eth0.

#> ifconfig eth0 netmask 255.255.255.0 # Configurer le masque de sous réseau.

#> ifconfig eth0 192.168.1.5 netmask 255.255.255.0 up # Changer adresse IP.

#> ifconfig eth0:0 172.16.25.127 # Ajouter un nouvel alias à l'interface eth0.

#> ifconfig eth0:0 down # Supprimer un  alias à l'interface eth0.

#> ifconfig eth0 hw ether AA:BB:CC:DD:EE:FF # Changer l'adresse MAC de eth0.
#-------------------------------------------------------------------------
#     							|IFSTAT|
#-------------------------------------------------------------------------
#> ifstat  # Affiche les ratios de paquets echangés par interfaces.
#-------------------------------------------------------------------------
#     							  |IP|
#-------------------------------------------------------------------------
#> ip route | awk '/default/{print $3}'  # Default gateway
#> ip li | grep ether | awk '{print $2}' # Show MAC adresse
#-------------------------------------------------------------------------
#     							 |ROUTE|
#-------------------------------------------------------------------------
#> route  # Affiche la table de routage
#-------------------------------------------------------------------------
#     						    |NETSTAT|
#-------------------------------------------------------------------------
#> netstat -tulp # Lister les ports ouverts

#> watch -n 1 "netstat -tpanl | grep ESTABLISHED" # Voir les connections TCP
												  # ouvertes.
#> netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -n
# Nombre de connections ouvertes par IP.

#> watch "netstat -plan|grep :80|awk {'print \$5'} | cut -d: -f 1 | sort | uniq -c | sort -nk 1"  # Monitor open connections for httpd including listen, count and sort it per IP	

#> netstat -lantp | grep ESTABLISHED |awk '{print $5}' | awk -F: '{print $1}' | sort -u
#-------------------------------------------------------------------------
#     							 |NMAP|
#-------------------------------------------------------------------------
#> nmap -v -sT --system-dns localhost  # Lister les ports ouverts

#> nmap -sP 192.168.1.0/24 # Lister les hotes connectés au sous-réseaux.

#> nmap -sP 192.168.1.100-254 # Pinger un range d'IP. 

#> nmap -sS -P0 -sV -O <target> # Obtenir les infos de ports ouverts
								# et detection os sur hôte distant. 

#> nmap -sT -p 80 -oG - 192.168.1.* | grep open	 # Lister les serveurs avec
												 # un port spécifique ouvert.
#> nmap -sP 192.168.1.0/24; arp -n  | grep "192.168.1.[0-9]* *ether
# Trouver toutes les IP actives sur un réseau.

#> nmap -T4 -sP 192.168.2.0/24 && egrep "00:00:00:00:00:00" /proc/net/arp
# Trouver les IP inutilisées sur un sous-réseaux.
#-------------------------------------------------------------------------
#     					   		  |NC|
#-------------------------------------------------------------------------
#> cat /etc/passwd | openssl aes-256-cbc -a -e -pass pass:password | netcat -l -p 8080
# Envoyer des données de façon sécurisé sur un réseau.

#=========================================================================
#					      |||| DEV COMMANDS ||||
#=========================================================================
#-------------------------------------------------------------------------
#     					         |MAKE|
#-------------------------------------------------------------------------
#> make -j 4   # Utiliser tous les CPU pour compiler.
#-------------------------------------------------------------------------
#     					        |OBJDUMP|
#-------------------------------------------------------------------------
#> objdump -f [BINARYFILE]  # Display the contents of the overall file header.

#> objdump -p [BINARYFILE]  # Display object format specific file header contents.

#> objdump -h [BINARYFILE]  # Display the contents of the section headers.

#> objdump -x [BINARYFILE]  # Display the contents of all headers.

#> objdump -d [BINARYFILE] | pager  # Display assembler contents of executable 
									# sections.

#> objdump -d [BINARYFILE] # Display assembler contents of all sections.

#> objdump -g [BINARYFILE] # Display debug information.

#> objdump -t [BINARYFILE] # Display the contents of symbol table (or tables).

#> objdump -T [BINARYFILE] # Display the contents of dynamic symbol table.

#> objdump -R [BINARYFILE] # Display the dynamic relocation entries in the file.

#> objdump -s -j[SECTIONNAME] [BINARYFILE]  # Display section of interest.

#> objdump -D --prefix-addresses [BINARYFILE] # prints the complete address on each 											  # line. 

#> for i in `objdump -d /bin/bash | tr '\t' ' ' | tr ' ' '\n' \
   | egrep '^[0-9a-f]{2}$' `; do echo -n "\\\x$i"; done  
# Pour voir tous les shellcode contenus dans un binaire.
#-------------------------------------------------------------------------
#     					           |LDD|
#-------------------------------------------------------------------------
#> ldd /bin/bash | awk 'BEGIN{ORS=","}$1~/^\//{print $1}$3~/^\//{print $3}' | sed 's/,$/\n/'  # Lister les librairies utilisées par une applications.						
ps -eo args,%cpu | grep -m1 PROCESS | tr 'a-z-' ' ' | awk '{print $1}'
