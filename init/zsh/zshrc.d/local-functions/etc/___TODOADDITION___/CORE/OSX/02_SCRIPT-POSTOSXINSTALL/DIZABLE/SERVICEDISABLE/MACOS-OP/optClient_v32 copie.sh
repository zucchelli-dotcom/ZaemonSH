#! /usr/bin/env /bin/bash

###
###########################################################################
# TODO
###########################################################################
# if wmware / if normal client
# local mdel=$(sysctl hw.model | awk '{print$2}')
# >>normal OSX clients >>>


##  Apercu need
# /System/Library/LaunchAgents/com.apple.bird.plist
# /Library/Frameworks/iTunesLibrary.framework

###########################################################################


################################################################################
#
#         						VARIABLES
#
################################################################################

##
##### LIBRARY PREFERENCES LIST
################################################################################
libPreferences="
com.apple.airport.opproam.plist
com.apple.Bluetooth.plist
com.apple.commerce.plist
com.apple.driver.AppleIRController.plist
com.apple.SoftwareUpdate.plist
com.apple.storeagent.plist
com.apple.TimeMachine.plist
com.apple.ViewBridge.plist
org.cups.printers.plist
Xsan/
"

#
##
##### EXTENSION LIST
################################################################################
disabledKextList="

"

#
##
##### SWAP PROCESS
################################################################################
# Check installed RAM, disable VM if 8Gb or more.
# mem_inst=`/usr/bin/sysctl -n hw.memsize`

# if [ "$mem_inst" -ge "8589934592" ]; then
# 	echo "8Gb Memory installed."
# 		if [ "$action" == "unload" ]; thern
# 			sudo nvram boot-args="vm_compressor=2"
# 			sudo pmset -a hibernatemode 0
# 			echo "vm.compressor_mode set to 2"
# 		else
# 			sudo nvram boot-args="vm_compressor=4"
# 			sudo pmset -a hibernatemode 3
# 			echo "vm.compressor_mode reset to defaults"
# 		fi
# 	launch_control $action /System/Library/LaunchDaemons/com.dynamic_pager
# 	else
# 	echo "Less than 8 Gb memory."
# fi

#
##
##### DEFAULTS PROCESS
###############################################################################
# defaults write com.apple.dock QuitFinder -bool "${defswitch}"

# defaults write com.apple.finder AppleShowAllFiles -bool "${defswitch}"
# defaults write com.apple.dock AppleShowAllFiles -bool "${defswitch}"
# defaults write com.apple.dock showhidden -bool "${defswitch}"

# defaults write com.apple.dashboard mcx-disabled -bool "${defswitch}"
# defaults write com.apple.dock mcx-expose-disabled -bool "${defswitch}"
# defaults write com.apple.finder QuitFinderuitMenuItem "${defswitch}"

# defaults write com.apple.finder AnimateWindowZoom -bool "${notdefswitch}"
# defaults write com.apple.finder DisableAllAnimations -bool "${defswitch}"
# defaults write com.apple.finder CreateDesktop -bool "${notdefswitch}"

# defaults write com.apple.dock single-app -bool "${defswitch}"

##### SPOTLIGHT
###############################################################################
# sudo -S mdutil -E / && sudo -S rm -fr /.Spotlight-V100 && sudo -S mdutil -i off / && sudo touch /.metadata_never_index





################################################################################
									 #
################################################################################





################################################################################
#
#         					 GEN FUNCTIONS
#
################################################################################
#
##
##### ROOT TEST FUNCTION
root () {
if [ "$USER" != "root" ]; then
	echo "You have to be root to run this script"
	exit 1
fi
}
#
##
##### TERMINATION FUNCTION
ending () {
echo "changes applied, the computer restart  now .."
sleep 2
wait
 sudo sync ; sudo sync ; sudo  shutdown -r now
}
#############################################################################################

							  # BACKUP SECTION

#############################################################################################


#####/ KEXT Backup
# if [ ! -s /System/Library/Extensions ]; then
	# sudo mkdir /System/Library/ExtensionsDisabled
# fi

#############################################################################################

					      # LAUNCH OPTIMISATION SECTION

#############################################################################################
#
##
##### 1a/ LAUNCH BACKUP
# Functions to Backup overrides.plist as a safety measure
# Only backup once as this should capture original state.
# Moving the overrides.bak -> overrides.plist will restore launch setup to original state.
launchBackup () {
# if [ ! -s /var/db/launchd.db/com.apple.launchd/overrides.bak ]; then
# 	sudo cp /var/db/launchd.db/com.apple.launchd/overrides.plist  /var/db/launchd.db/com.apple.launchd/overrides.bak
# fi

# if [ ! -s /var/db/launchd.db/com.apple.launchd.peruser.501/overrides.bak ]; then
# 	sudo cp /var/db/launchd.db/com.apple.launchd.peruser.501/overrides.plist  /var/db/launchd.db/com.apple.launchd/overrides.bak
# fi

#####LAUNCH AND DAEMONS OPTIMISTAIONS DIRECTORIES
if [ ! -s /System/Library/LaunchDaemonsDisabled ]; then
	sudo mkdir /System/Library/LaunchDaemonsDisabled
fi

if [ ! -s /System/Library/LaunchAgentsDisabled ]; then
	sudo mkdir /System/Library/LaunchAgentsDisabled
fi

if [ ! -s /Library/LaunchDaemonsDisabled ]; then
	sudo mkdir /Library/LaunchDaemonsDisabled
fi

if [ ! -s /Library/LaunchAgentsDisabled ]; then
	sudo mkdir /Library/LaunchAgentsDisabled
fi
## AUDIO SHITY PLUGINS
if [ ! -s /Library/AudioDisabled ]; then
	sudo mkdir /Library/AudioDisabled
fi
#######
if [ ! -s /Users/"$USER"/Library/LaunchAgentsDisabled ]; then
	sudo mkdir /Users/"$USER"/Library/LaunchAgentsDisabled
fi

}
launchDaemonsDisabled=""

#
##
##### 1b/ SYSTEM LAUNCH LIST TO CONTROL
################################################################################
launchDaemons="
bootps
com.apple.afpfs_afpLoad
com.apple.afpfs_checkafp
com.apple.AirPlayXPCHelper


com.apple.appleseed.fbahelperd
com.apple.apsd
com.apple.awacsd
com.apple.awdd
com.apple.backupd-auto
com.apple.backupd
com.apple.cloudfamilyrestrictionsd-mac
com.apple.cmio.AppleCameraAssistant
com.apple.cmio.AVCAssistant
com.apple.cmio.IIDCVideoAssistant
com.apple.cmio.iOSScreenCaptureAssistant
com.apple.cmio.VDCAssistant
com.apple.comsat
com.apple.CoreRAID
com.apple.dpd
com.apple.dvdplayback.setregion
com.apple.efax
com.apple.findmymac
com.apple.findmymacmessenger
com.apple.firmwaresyncd
com.apple.GameController.gamecontrollerd
com.apple.icloud.findmydeviced
com.apple.installandsetup.systemmigrationd
com.apple.IOBluetoothUSBDFU
com.apple.Kerberos.digest-service
com.apple.Kerberos.kadmind
com.apple.Kerberos.kcm
com.apple.Kerberos.kdc
com.apple.Kerberos.kpasswdd
com.apple.locationd
com.apple.ManagedClient.cloudconfigurationd
com.apple.ManagedClient.enroll
com.apple.ManagedClient
com.apple.ManagedClient.startup
com.apple.mbicloudsetupd
com.apple.mdmclient.daemon
com.apple.metadata.mds.index
com.apple.metadata.mds
com.apple.metadata.mds.scan
com.apple.metadata.mds.spindump
com.apple.msrpc.echosvc
com.apple.msrpc.lsarpc
com.apple.msrpc.mdssvc
com.apple.msrpc.netlogon
com.apple.msrpc.srvsvc
com.apple.msrpc.wkssvc
com.apple.mtmd
com.apple.mtmfs
com.apple.netbiosd
com.apple.NetBootClientStatus
com.apple.nfsconf
com.apple.nfsd
com.apple.nis.ypbind
com.apple.nsurlsessiond
com.apple.nsurlstoraged

com.apple.printtool.daemon
com.apple.racoon
com.apple.RemoteDesktop.PrivilegeProxy
com.apple.remotepairtool
com.apple.rpcbind
com.apple.screensharing
com.apple.smb.preferences
com.apple.smbd







com.apple.xpc.smd
com.apple.xsan
com.apple.xsandaily
com.apple.xscertadmin
com.apple.xscertd-helper
com.apple.xscertd
ntalk
org.apache.httpd
org.cups.cups-lpd
org.cups.cupsd
org.openldap.slapd
org.postfix.master
telnet
tftp
"
####BAD
# com.apple.MobileFileIntegrity
#>> Quicksilver spectacle Crash
# com.apple.tccd.system
#>> need by spectacle
# com.apple.audio.coreaudiod
# com.apple.mdmclient.daemon
#>> Slow down Finder
####++VMWARRE
# com.apple.airport.wps
# com.apple.airportd
# com.apple.softwareupdate_download_service
# com.apple.softwareupdate_firstrun_tasks
# com.apple.softwareupdated
# com.apple.storereceiptinstaller
# com.apple.wifid.plist
# com.apple.wirelessproxd.plist
# com.apple.wwand.plist
###TOTEST
#####

##### LIBRARY LAUNCH LIST TO CONTROL
##
launchAgents="
com.apple.AddressBook.abd
com.apple.AddressBook.AssistantService
com.apple.AddressBook.SourceSync
com.apple.AirPlayUIAgent

com.apple.aos.migrate
com.apple.AOSHeartbeat
com.apple.AOSPushRelay
com.apple.appleseed.seedusaged

com.apple.apsctl
com.apple.assistant_service
com.apple.assistantd
com.apple.AssistiveControl
com.apple.bird
com.apple.blued
com.apple.bluetoothaudiod
com.apple.bluetoothReporter
com.apple.bluetoothUIServer
com.apple.bnepd
com.apple.btsa
com.apple.CalendarAgent
com.apple.CallHistoryPluginHelper
com.apple.CallHistorySyncHelper
com.apple.cloudd
com.apple.cloudfamilyrestrictionsd-mac
com.apple.cloudpaird
com.apple.cloudphotosd
com.apple.cmfsyncagent
com.apple.CoreRAIDAgent
com.apple.DictationIM
com.apple.dt.CommandLineTools.installondemand
com.apple.familycircled
com.apple.familycontrols.useragent
com.apple.familynotificationd
com.apple.FileSyncAgent.PHD
com.apple.findmymacmessenger
com.apple.gamed
com.apple.icbaccountsd
com.apple.icloud.fmfd
com.apple.iCloudUserNotifications
com.apple.identityservicesd
com.apple.idsremoteurlconnectionagent
com.apple.imagent
com.apple.IMLoggingAgent
com.apple.java.InstallOnDemand
com.apple.java.updateSharing
com.apple.ManagedClientAgent.agent
com.apple.ManagedClientAgent.enrollagent
com.apple.Maps.pushdaemon
com.apple.maspushagent
com.apple.mdmclient.agent
com.apple.mdmclient.cloudconfig.agent
com.apple.mdworker.32bit
com.apple.mdworker.bundles
com.apple.mdworker.isolation
com.apple.mdworker.lsb
com.apple.mdworker.mail
com.apple.mdworker.shared
com.apple.mdworker.single
com.apple.mdworker.sizing
com.apple.metadata.mdflagwriter
com.apple.metadata.mdwrite
com.apple.metadata.SpotlightNetHelper
com.apple.midiserver
com.apple.nsurlsessiond
com.apple.nsurlstoraged
com.apple.parentalcontrols.check
com.apple.photolibraryd
com.apple.PhotoLibraryMigrationUtility.XPC
com.apple.printtool.agent
com.apple.printuitool.agent
com.apple.PubSub.Agent
com.apple.rcd
com.apple.recentsd
com.apple.RemoteDesktop
com.apple.safaridavclient
com.apple.SafariNotificationAgent
com.apple.sbd
com.apple.ScreenReaderUIServer
com.apple.screensharing.agent
com.apple.screensharing.MessagesAgent
com.apple.security.cloudkeychainproxy
com.apple.sharingd
com.apple.soagent
com.apple.SocialPushAgent

com.apple.speech.speechdatainstallerd
com.apple.speech.speechsynthesisd
com.apple.speech.synthesisserver
com.apple.Spotlight
com.apple.SSInvitationAgent






com.apple.syncdefaultsd
com.apple.syncservices.SyncServer
com.apple.syncservices.uihandler
com.apple.tccd
com.apple.telephonyutilities.callservicesd
com.apple.VoiceOver

com.apple.xmigrationhelper.user
"
###BAD TO UNLOAD
# com.apple.talagent # If disable, Slow down the down.
# com.apple.nsurlsessiond
# com.apple.nsurlstoraged

## ++VMWRE
# com.apple.AirPortBaseStationAgent.plist
# com.apple.appstoreupdateagent
# com.apple.storeaccountd
# com.apple.storeassetd
# com.apple.storedownloadd
# com.apple.storeinappd
# com.apple.storelegacy
# com.apple.storeuid
# com.apple.softwareupdate_notify_agent.plist
# com.apple.wifi.WiFiAgent.plist
###TOTEST
#
#####

#
##
##### LIBRARY LAUNCH LIST
################################################################################
# List of libraryLaunchAgents to control
libraryLaunchAgents="
com.adobe.AAM.Updater-1.0
com.adobe.CS5ServiceManager
xorg.macosforge.xquartz.startx
"
# List of libraryLaunchDaemons to control
libraryLaunchDaemons="
org.macosforge.xquartz.privileged_startx
com.adobe.SwitchBoard
org.wireshark.ChmodBPF
"
#
##
##### USER LAUNCH LIST
################################################################################
# List of userLaunchAgents to control
userLaunchAgents="
com.adobe.ARM.df0ab5bbe6f698196fcc21e3c1e66dcb758bd911f4d637272d9d8109
"
#
##
##### SHIT APP LIST
################################################################################
disableShitApps="
/System/Library/CoreServices/Dock.app/Contents/XPCServices/com.apple.dock.extra.xpc
/Applications/iTunes.app/Contents/MacOS/iTunesHelper.app
/System/Library/PrivateFrameworks/BookKit.framework/XPCServices/com.apple.BKAgentService.xpc
/Library/Audio/Plug-Ins/HAL/AirPlay.driver/Contents/MacOS/AirPlay
"
#
#---------------------------------------------------------------------------------------------

						  # 1/ LAUNCH CONTROL SECTION

#---------------------------------------------------------------------------------------------
#
##
#####
# Function to e,nable or disable Agents and Daemons
# requires three args - action, , process_name
launch_control () {
if [ "$1" = "unload" ]; then
	src_suf=""
	tgt_suf="Disabled"
else
	src_suf="Disabled"
	tgt_suf=""
fi

if [ -s "${2}${src_suf}/${3}.plist" ]; then
	sudo mv ${2}${src_suf}/${3}.plist ${2}${tgt_suf}/${3}.plist ;
	echo "${1} ${3}"
else
	echo "Launch process not found: $3" 2>/dev/null
	echo ""
fi
}
#
##
##### SYSTEM LAUNCH ACTIONS
################################################################################
SyslaunchDaemonsPatternAction () {
echo ""
echo "##############################"
echo "• LAUNCHDAEMONS OPTIMISATIONS"
echo "##############################"
# Process list of LauchDaemons
for launchItems in $launchDaemons
do
		launch_control $action /System/Library/LaunchDaemons $launchItems
done
echo "##############################"
echo ""
}

SyslaunchAgentsPatternAction () {
echo "##############################"
echo "• LAUNCHAGENTS OPTIMISATIONS"
echo "##############################"
# Process list of LauchAgents
for launchItems in $launchAgents
do
		launch_control $action /System/Library/LaunchAgents $launchItems
done
echo "##############################"
}
#
##
##### LIBRARY LAUNCH PROCESS
################################################################################
LibrarylaunchDaemonsPatternAction () {
echo "#################################"
echo "• LIBRARYLAUNCHDAEMONS OPTIMISATIONS"
echo "#################################"
# Process list of libraryLauchDaemons
for launchItems in $libraryLaunchDaemons
do
		launch_control $action /Library/LaunchDaemons $launchItems
done
echo "##############################"
}


LibrarylaunchAgentsPatternAction () {
echo "#################################"
echo "• LIBRARYLAUNCHDAEMONS OPTIMISATIONS"
echo "#################################"
# Process list of libraryLauchAgents
for launchItems in $libraryLaunchAgents
do
		launch_control $action /Library/LaunchAgents $launchItems
done
echo "##############################"
}
#
##
##### USERS LAUNCH PROCESS
################################################################################
UserlaunchAgentsPatternAction () {
echo "#################################"
echo "• USERLAUNCHAGENTS OPTIMISATIONS"
echo "#################################"
# Process list of userLauchAgents
for launchItems in $userLaunchAgents
do
		launch_control $action ~/Library/LaunchAgents $launchItems
done
echo "##############################"
}
#
##
##### SHIT APP PROCESS
################################################################################
shitApp () {
if [ "$actions" == "unload" ]; then
		fileperms=444
		defswitch=YES
		notdefswitch=NO
		finderBool=1
else
		fileperms=755
		defswitch=NO
		notdefswitch=YES
		finderBool=0
fi
for filetofix in $disableShitApps
do
	echo "filetofix"
	sudo chmod "$fileperms" "$filetofix"
done
}
#
##
##### SHITY AUDIO PLUGINS
################################################################################
shitAudioPlugins () {
sudo mkdir /Library/AudioDisabled
sudo mv /Library/Audio/* /Library/AudioDisabled
}
#
##
##### LAUNCH MENU
################################################################################
# Function launch optimisations options
# menu.
launchmenu () {
		clear
		echo "######################################"
		echo "1/ LAUNCH OPTIMISATION "
		echo "######################################"
		echo "1. Install All Syslaunch (Agents and Daemons) Pattern Optimisations"
		echo "2. Remove All Syslaunch  (Agents and Daemons) Pattern Optimisations"
		echo "3. List SyslaunchDaemons plist in Pattern Optimisations"
		echo "4. Install Just SyslaunchDaemons Pattern Optimisations"
		echo "5. Remove Just SyslaunchDaemons Pattern Optimisations"
		echo "6. Install Just SyslaunchAgents Pattern Optimisations"
		echo "7. Remove Just SyslaunchAgents Pattern Optimisations"
		echo "8. Add Daemons plist to pattern optimisation list"
		echo "R. Menu précédent"
		echo "Q. Exit"
		read opx
		case $opx in
			1)  echo ""
				echo "######################################"
				echo ">>>APPLY ALL SYSLAUNCH OPTIMISATIONS"
				echo "######################################"
			   	action="unload"
			   	launchBackup
			   	SyslaunchDaemonsPatternAction
			   	SyslaunchAgentsPatternAction
			   	LibrarylaunchDaemonsPatternAction
			   	LibrarylaunchAgentsPatternAction
			   	shitAudioPlugins						## hack for shity audio plugins
			   	UserlaunchAgentsPatternAction
			   	shitApp
			   	ending
			   ;;
			2) 	echo ""
				echo "######################################"
				echo ">>>REMOVE ALL SYSLAUNCH OPTIMISATIONS"
				echo "######################################"
			   	action="load"
			   	launchBackup
			   	SyslaunchDaemonsPatternAction
			   	SyslaunchAgentsPatternAction
			   	LibrarylaunchDaemonsPatternAction
			   	LibrarylaunchAgentsPatternAction
			   	shitAudioPlugins 						## hack for shity audio plugins
			   	UserlaunchAgentsPatternAction
			   	shitApp
			   	ending
			   ;;
			3) 	echo ""
				echo "##############################################"
				echo ">>>LIST SYSLAUNCHDAEMONS OPTIMISATIONS"
				echo "##############################################"
				echo "$launchDaemons"
				sleep 5
				wait
				launchmenu
			   ;;

			4) 	echo ""
				echo "##############################################"
				echo ">>>APPLY JUST SYSLAUNCHDAEMONS OPTIMISATIONS"
				echo "##############################################"
		   		action="unload"
		   		launchBackup
		   		SyslaunchDaemonsPatternAction
		   		ending
			   ;;
			5) 	echo ""
				echo "##############################################"
				echo ">>>REMOVE JUST SYSLAUNCHDAEMONS OPTIMISATIONS"
				echo "##############################################"
		   		action="load"
		   		launchBackup
		   		SyslaunchDaemonsPatternAction
		   		ending
			   ;;
			6) 	echo ""
				echo "##############################################"
				echo ">>>APPLY JUST SYSLAUNCHAGENTS OPTIMISATIONS"
				echo "##############################################"
		   		action="unload"
		   		launchBackup
		   		SyslaunchAgentsPatternAction
		   		ending
			   ;;
			7) 	echo ""
				echo "##############################################"
				echo ">>>REMOVE JUST SYSLAUNCHAGENTS OPTIMISATIONS"
				echo "##############################################"
		   		action="load"
		   		launchBackup
		   		SyslaunchAgentsPatternAction
		   		ending
			   ;;
		    8) 	echo ""
				echo "##############################################"
				echo ">>>ADD  SYSLAUNCHDAEMONS PLIST OPTIMISATIONS"
				echo "##############################################"
				# ListePatt=Pattern de Daemons prédéfinis.
		   		# ListeDActivés=Liste de Daemons actuellement activés.
		   		# ListeDDésactivés=Liste de Daemons actuellement désactivé.
		   		# nomdupatternajouter Choix dans liste avec $(ls
		   		#launchDaemons="$lauchDaemons $nomduplistnajouteraupattern"
		   		#for i in $(ls /System/Library/LaunchDaemons/ | sed 's/......$//' ); do echo $i; done
		   		LISTE_REP="Quitter $(ls -1 /System/Library/LaunchDaemons/ | sed 's/......$//' )"
			   	PS3='Entrer votre choix?' # Invite de sélection.
				until [[ "$REPERTOIRE" == "Quitter" ]]; do
				echo-e "${GREEN}Sélectionnez le répertoire à analyser : ${NC}" >&2
				select REPERTOIRE in $LISTE_REP; do
				# LOG_TARGET="/"$REPERTOIRE
				# LOT_TGT="/"$REPERTOIRE"/"
				if [[ "$REPERTOIRE" = "Quitter" ]]; then
					echo -e "${RED}Analyse des répertoires terminée.${NC}"
					sleep 2
					launchmenu
					break
				elif [[ -n "$REPERTOIRE" ]]; then
					echo -e "Vous avez choisi le numéro ${RED}$REPLY${NC},"
					echo -e "ajout de ${RED}$REPERTOIRE${NC}au pattern..."
					launchdaemons="$launchDaemons$REPERTOIRE"
					echo "$launchdaemons"
					sleep 5
					launchmenu
					break
				else
					"$ECHO" -e "${RED}Sélection invalide !{NC}"
				fi # Fin du traitement du choix de l'utilisateur.
				break
				done # Fin de la sélection d'un répertoire
				break
				done

			   ;;
			R) echo "Menu Précédent"
			   main
			   ;;
			Q) echo "Exit"
			   exit 1
			   ;;
			*) echo "Invalid Option"
			   sleep 2
			   wait
			   launchmenu
			   ;;
		esac


}

#---------------------------------------------------------------------------------------------

						  # 2/ CORESERVICES CONTROL SECTION

#---------------------------------------------------------------------------------------------
#
##
##### 2a/ CORSERVICE BACKUP
coreservicesBackup () {
if [ ! -s /System/Library/CoreServicesDisabled ]; then
	sudo mkdir /System/Library/CoreServicesDisabled
	if [ ! -s /System/Library/CoreServices/ApplicationsDisabled ]; then
		sudo mkdir /System/Library/CoreServicesDisabled/ApplicationsDisabled
	fi
fi
}
#
##
##### 2b/ CORESERVICES LIST
################################################################################
###+++++TODO
# mkdir /System/Library/CoreServicesDisabled/ApplicatonsDisabled
# cd /System/Library/CoreServices/Applications && mvs /System/Library/CoreServices/Applicatons/Feedback\ Assistant.app /System/Library/CoreServices/Applicatons/Wireless\ Diagnostics.app /System/Library/CoreServices/Applicatons/Screen\ Sharing.app /System/Library/CoreServices/Applicatons/System\ Image\ Utility.app /System/Library/CoreServices/Applicatons/RAID\ Utility.app /System/Library/CoreServicesDisabled/ApplicatonsDisabled
CoreServices="
AddPrinter
AddressBookUrlForwarder
Agent de la borne d’accès AirPort
Agent Photos
AirPlayUIAgent
AOS.bundle
AOSMigrateAgent
AppDownloadLauncher
Assistant de certification
Assistant réglages
Assistant réglages Bluetooth
Assistant réglages de réseau
Automator Runner
BluetoothUIServer
CalendarFileHandler
cloudpaird
GoogleSyncMigrate
Jar Launcher
Java Web Start
mapspushd
OBEXAgent
Photo Library Migration Utility
rcd
RemoteManagement/
RemotePairTool
ScopedBookmarkAgent
Search.bundle
ShareBear
SocialPushAgent
Spotlight
VoiceOver
Wi-Fi
"
####++VMWARE
# ODSAgent
# Wi-Fi
####BAD
# Backupd.bundle
# talagent
#
##
##### 2c/ CORESERVICES CONTROL
################################################################################
core_control () {
if [ "$1" = "unload" ]; then
	src_suf=""
	tgt_suf="Disabled"
else
	src_suf="Disabled"
	tgt_suf=""
fi

if [ -s "${2}${src_suf}/${3}" ]; then
	sudo mv ${2}${src_suf}/${3} ${2}${tgt_suf}/${3} ;
	echo "${1} ${3}"
else
	echo "Launch process not found: $3" 2>/dev/null
	echo ""
fi
}
#
##
##### 2d/ CORESERVICES PROCESS
################################################################################
coreservicesAction () {
echo "#################################"
echo "• CORESERVICES OPTIMISATIONS"
echo "#################################"
# Process list of userLauchAgents
mv "/System/Library/CoreServices/Applications/Screen Sharing.app" /System/Library/CoreServicesDisabled/ApplicatonsDisabled/
mv "/System/Library/CoreServices/Applications/Feedback Assistant.app" /System/Library/CoreServicesDisabled/ApplicatonsDisabled/
mv "/System/Library/CoreServices/Applications/Wireless Diagnostics.app" /System/Library/CoreServicesDisabled/ApplicatonsDisabled/
mv "/System/Library/CoreServices/Applications/System Image Utility.app" /System/Library/CoreServicesDisabled/ApplicatonsDisabled/
mv "/System/Library/CoreServices/Applications/RAID Utility.app" /System/Library/CoreServicesDisabled/ApplicatonsDisabled/
for CoreS in $CoreServices
do
		core_control $action /System/Library/CoreServices "${CoreS}"
done
echo "##############################"
}
#---------------------------------------------------------------------------------------------

						  # 3/ /USR CONTROL SECTION

#---------------------------------------------------------------------------------------------
usrBackup () {
if [ ! -s /usr/libexecDisabled ]; then
	sudo mkdir /usr/libexecDisabled
fi

if [ ! -s /usr/sbinDisabled ]; then
	sudo mkdir /usr/sbinDisabled
fi
}
#
##
##### USR/LIBEXEC LIST
libexecList="
AirPlayXPCHelper
apache2/
awacsd
bootpd
cloudconfigurationd
comsat
cups/
dpd
fax/
feedback/
femail
findmydeviced
InternetSharing
ippusbd
mcxalr
mdmclient
neagent
nsurlsessiond
nsurlstoraged
otherbsd
postfix/
rlogind
rpc.rquotad
rpcsvchost
rshd
SafariCloudHistoryPushAgent
SafariNotificationAgent
sharingd
slapd
SmartCardServices/
smb-migrate-preferences
smb-sync-preferences
telnetd
"
#
##
##### /USR/SBIN LIST
################################################################################
sbinList="
ab
accept
apachectl
apxs
blued
bluetoothaudiod
bnepd
chat
cupsaccept
cupsaddsmb
cupsctl
cupsd
cupsdisable
cupsenable
cupsfilter
cupsreject
cvadmin
cvdb
cvdbset
cvfsck
cvfsdb
cvfsid
cvgather
cvlabel
cvmkfs
cvupdatefs
cvversions
htcacheclean
htdbm
htdigest
htpasswd
httpd
httpd-wrapper
httxt2dbm
lpadmin
lpc
lpinfo
lpmove
netbiosd
NetBootClientStatus
postcat
postconf
postdrop
postfix
postkick
postlock
postlog
postmap
postmulti
postqueue
postsuper
reject
rpc.lockd
rpc.statd
rpcbind
rpcinfo
sa
slapacl
slapadd
slapauth
slapcat
slapconfig
slapdn
slapindex
slappasswd
slapschema
slaptest
smbd
sndiskmove
snmetadump
xsanctl
"

usr_control () {
if [ "$1" = "unload" ]; then
	src_suf=""
	tgt_suf="Disabled"
else
	src_suf="Disabled"
	tgt_suf=""
fi

if [ -s "${2}${src_suf}/${3}" ]; then
	sudo mv ${2}${src_suf}/${3} ${2}${tgt_suf}/${3} ;
	echo "${1} ${3}"
else
	echo "Launch process not found: $3" 2>/dev/null
	echo ""
fi
}
usrlibexecAction () {
echo "#################################"
echo "• USRLIBEXEC OPTIMISATIONS"
echo "#################################"
# Process list of userLauchAgents
for libexecItems in $libexecList
do
		usr_control $action /usr/libexec $libexecItems
done
echo "##############################"
}
usrsbinAction () {
echo "#################################"
echo "• USRSBIN OPTIMISATIONS"
echo "#################################"
# Process list of userLauchAgents
for sbinItems in $sbinList
do
		usr_control $action /usr/sbin $sbinItems
done
echo "##############################"
}

#---------------------------------------------------------------------------------------------

						  # 4/ /var/DB CONTROL SECTION

#---------------------------------------------------------------------------------------------
#
##
##### /VAR/DB
################################################################################
vardbBackup () {
if [ ! -s /private/var/dbDisabled ]; then
	sudo mkdir /private/var/dbDisabled
fi
}
vardbList="
awdd/
dhcpclient/
geod/
nsurlsessiond/
Spotlight/
"
vardb_control () {
if [ "$1" = "unload" ]; then
	src_suf=""
	tgt_suf="Disabled"
else
	src_suf="Disabled"
	tgt_suf=""
fi

if [ -s "${2}${src_suf}/${3}" ]; then
	sudo mv ${2}${src_suf}/${3} ${2}${tgt_suf}/${3} ;
	echo "${1} ${3}"
else
	echo "Launch process not found: $3" 2>/dev/null
	echo ""
fi
}
vardbAction () {
echo "#################################"
echo "• VARDB OPTIMISATIONS"
echo "#################################"
# Process list of userLauchAgents
for vardbItems in $vardbList
do
		vardb_control $action /private/var/db $vardbItems
done
echo "##############################"
}
#---------------------------------------------------------------------------------------------

						  # 5/ EXTENSIONS CONTROL SECTION

#---------------------------------------------------------------------------------------------
#
##
##### 3a/ KEXT BACKUP
# Functions to Backup overrides.kext as a safety measure
kextBackup () {
if [ ! -s /System/Library/ExtensionsDisabled ]; then
	sudo mkdir /System/Library/ExtensionsDisabled
fi
}
#
##
##### 3b/ KEXT CONTROL
kext_control () {
if [ "$1" = "unload" ]; then
	src_suf=""
	tgt_suf="Disabled"
else
	src_suf="Disabled"
	tgt_suf=""
fi

if [ -s "${2}${src_suf}/${3}.kext" ]; then
	sudo mv ${2}${src_suf}/${3}.kext ${2}${tgt_suf}/${3}.kext ;
	echo "${1} ${3}"
else
	echo "Launch process not found: $3" 2>/dev/null
	echo ""
fi
}
#
##
##### 3c/ KEXT ACTION
################################################################################
kextItemsItems=
"
AMD2400Controller.kext/
AMD2600Controller.kext/
AMD3800Controller.kext/
AMD4600Controller.kext/
AMD4800Controller.kext/
AMD5000Controller.kext/
AMD6000Controller.kext/
AMD7000Controller.kext/
AMD8000Controller.kext/
AMD9000Controller.kext/
AMDFramebuffer.kext/
AMDRadeonVADriver.bundle/
AMDRadeonX3000.kext/
AMDRadeonX3000GLDriver.bundle/
AMDRadeonX4000.kext/
AMDRadeonX4000GLDriver.bundle/
AMDSupport.kext/
ATIRadeonX2000.kext/
ATIRadeonX2000GA.plugin/
ATIRadeonX2000GLDriver.bundle/
ATIRadeonX2000VADriver.bundle/
AppleBluetoothMultitouch.kext/
AppleCameraInterface.kext/
AppleHIDKeyboard.kext/
AppleHIDMouse.kext/
AppleHPM.kext/
AppleIntelHD3000Graphics.kext/
AppleIntelHD3000GraphicsGA.plugin/
AppleIntelHD3000GraphicsGLDriver.bundle/
AppleIntelHD3000GraphicsVADriver.bundle/
AppleIntelHD5000Graphics.kext/
AppleIntelHD5000GraphicsGLDriver.bundle/
AppleIntelHD5000GraphicsVADriver.bundle/
AppleIRController.kext
AppleMIDIBluetoothDriver.plugin/
AppleMIDIFWDriver.plugin/
AppleMIDIIACDriver.plugin/
AppleMIDIRTPDriver.plugin/
AppleMIDIUSBDriver.plugin/
AppleThunderboltDPAdapters.kext/
AppleThunderboltEDMService.kext/
AppleThunderboltIP.kext/
AppleThunderboltNHI.kext/
AppleThunderboltPCIAdapters.kext/
AppleThunderboltUTDM.kext/
AppleXsanFilter.kext/
Apple_iSight.kext/
GeForce.kext/
GeForceGA.plugin/
GeForceGLDriver.bundle/
GeForceTesla.kext/
GeForceTeslaGLDriver.bundle/
GeForceTeslaVADriver.bundle/
GeForceVADriver.bundle/
IOBluetoothFamily.kext/
IOBluetoothHIDDriver.kext/
IOThunderboltFamily.kext/
NVDAGF100Hal.kext/
NVDAGK100Hal.kext/
NVDANV50HalTesla.kext/
NVDAResman.kext/
NVDAResmanTesla.kext/
NVDAStartup.kext/
PPP.kext/
PPPSerial.ppp/
PPPoE.ppp/
PPTP.ppp/
acfs.kext/
acfsctl.kext/
iPodDriver.kext/
ntfs.kext/
smbfs.kext/
webdav_fs.kext/
"
kextAction () {
echo ""
echo "##############################"
echo "• KEXTs OPTIMISATIONS"
echo "##############################"
# Process list of kext
for kextItemsItems in $KextList
do
		kext_control $action /System/Library/Extensions $kextItemsItems
done
echo "##############################"
echo ""
}


################################################################################

#         					  MAIN

################################################################################

main () {
root
wait
clear
echo ""
# echo "-----------------------------"
# echo $(date)
# echo "-----------------------------"
# echo ""
echo "######################################"
echo "OSX OPTIMISATIONS APP"
echo "######################################"
echo "1. LAUNCH OPTIMISATIONS"
echo "2. CORESERVICES OPTIMISATIONS"
echo "3. /USR OPTIMISATION"
echo "4. /VAR/DB OPTIMISATION"
echo "5. EXTENSIONS OPTIMISATION"
echo "6. DEFAULTS OPTIMISATION"
echo "Q. Exit"
read opt
case $opt in
	1)  echo ""
		echo "######################################"
		echo "1/ LAUNCH OPTIMISATIONS"
		echo "######################################"
		launchmenu
		;;
	2) 	echo ""
		echo "######################################"
		echo "2/ CORESERVICES OPTIMISATIONS"
		echo "######################################"
		action="unload"
		coreservicesBackup
		coreservicesAction
	   ;;
	3) 	echo ""
		echo "######################################"
		echo "3/ /USR/ OPTIMISATION" #(LIBEXEC&SBIN)
		echo "######################################"
		action="unload"
		usrBackup
		usrlibexecAction
		usrsbinAction
	   ;;
	4) 	echo ""
		echo "##############################################"
		echo "4/ DB OPTIMISATION"
		echo "##############################################"
	   	action="unload"
	   	vardbBackup
	   	vardbAction
	   ;;
	5) 	echo ""
		echo "##############################################"
		echo "5/ EXTENSIONS OPTIMISATION"
		echo "##############################################"
		kextBackup
		kextAction
	   ;;
	6) 	echo ""
		echo "##############################################"
		echo "6/ DEFAULTS OPTIMISATION"
		echo "##############################################"

	   ;;
	Q) echo "Exit"
	   exit 1
	   ;;
	*) echo "Invalid Option"
	   sleep 2
	   wait
	   main
	   ;;
esac
}
main




############################################################################

