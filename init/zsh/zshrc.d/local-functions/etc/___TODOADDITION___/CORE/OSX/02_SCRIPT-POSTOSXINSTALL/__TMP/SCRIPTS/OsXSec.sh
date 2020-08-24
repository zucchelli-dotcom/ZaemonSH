#:/usr/bin/env bash


#      
#      ••• Generals settings
#      ••• Generals security settings
#         •• Firewall
#         •• DNS ...
#      ••• Disable Filesystems     
#      ••• Disable Launch/Daemons services
#      ••• Disable Kext extensions
#      ••• Disable CoreServices

#      ••• Filesystems
#      ••• Filesystems
#      ••• Filesystems
#      ••• Filesystems
#      ••• Filesystems
#      ••• Filesystems




if [ $USER != "root" ]; then
     echo "you are to be root to run this script" && exit 0
fi  

# Updating from an Internal Software Update Server 
# ------------------------------------------------ 
# Default Settings:
# blank
# Software updates are downloaded from one of the following software update
# servers hosted by Apple:
# swscan.apple.com:80
# swquery.apple.com:80
# swcdn.apple.com:80
# Suggested Settings:
# Specify the software update server to use.
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CatalogURL http://swupdate.apple.com:8088/index-leopard-snowleopard.merged- 1.sucatalog
# Available Settings:
# Replace swupdate.apple.com with the fully qualified domain name (FQDN) # or IP address of your software update server.
# To switch your computer back to the default Apple update server.
# defaults delete com.apple.SoftwareUpdate CatalogURL
# Updating from Internet Software Update Server
# -----------------------------------
# Default Settings:
# The softwareupdate command by default checks and lists available # updates for download. Software Update preferences are set to the # command-line equivalent of:
# softwareupdate --list --schedule on
# Suggested Settings:
# Download and install software updates.
sudo softwareupdate --download --all --install
# Available Settings:
# Use the following commands to view softwareupdate options: # $ softwareupdate -h
# or
# $ man softwareupdate
# Updating Manually from Installer Packages 
# -----------------------------------
# Default Settings:
# None
# Suggested Settings:
# Download software updates.
sudo softwareupdate --download --all
# Install software updates.
sudo installer -pkg $Package_Path -target /Volumes/$Target_Volume
# Available Settings:
# Use the following commands to view installer options: # $ installer -h
# or
# $ man installer
# Verifying the Integrity of Software 
# ----------------------------------- 
# Default Settings:
# None
# Suggested Settings:
# Use the sha1 command to display a file’s SHA-1 digest.
# Replace $full_path_filename with the full path filename of the update # package or image that SHA-1 digest is being checked for.
sudo /usr/bin/openssl sha1 $full_path_filename
# Available Settings:
# Use the following command to view the version of OpenSSl installed on # your computer:
# $ openssl version
# Use the following command to view openssl options:
# $ man openssl
# Using Disk Utility to Repair Disk Permissions 
# -----------------------------------
# Default Setting:
# None
# Suggested Setting:
# Verify disk permissions
sudo diskutil verify Permissions /Volumes/$Target_Boot_Drive
# If permission discrepancies exist that were not set by your
# organizations, use the following Repair disk permissions command: sudo diskutil repairPermissions /Volumes/$Target_Boot_Drive
# Available Setting:
# Use the following command to view diskutil options: # $ diskutil
# -------------------------------------------------------------------
# Securing System Hardware
# -------------------------------------------------------------------
# Removing Wi-Fi Support Software
# -------------------------
# Default setting:
# kext files are installed and loaded.
# Suggested Setting:
# Remove Apple AirPort kernel extensions.
sudo srm -rf /System/Library/Extensions/IO80211Family.kext # Remove Extensions cache files.
sudo touch /System/Library/Extensions
# Available Settings:
# None
# Removing BlueTooth Support Software 
# -----------------------------
# Default setting:
# kext files are installed and loaded.
# Suggested Setting:
# Remove Bluetooth kernel extensions.
sudo srm -rf /System/Library/Extensions/IOBluetoothFamily.kext sudo srm -rf /System/Library/Extensions/IOBluetoothHIDDriver.kext # Remove Extensions cache files.
sudo touch /System/Library/Extensions
# Available Settings: # None
# Removing IR Support Software
# -----------------------------
# Default setting:
# kext files are installed and loaded.
# Suggested Setting:
# Remove IR kernel extensions.
sudo srm -rf /System/Library/Extensions/AppleIRController.kext # Remove Extensions cache files.
sudo touch /System/Library/Extensions
# Available Settings: # None
# Securing Audio Support Software
# -----------------------------
# Default setting:
# kext files are installed and loaded.
# Suggested Setting:
# Remove Audio Recording kernel extensions.
sudo srm -rf /System/Library/Extensions/AppleUSBAudio.kext sudo srm -rf /System/Library/Extensions/IOAudioFamily.kext # Remove Extensions cache files.
sudo touch /System/Library/Extensions
# Available Settings: # None
# Securing Video Recording Support Software 
# -----------------------------
# Default setting:
# kext files are installed and loaded.
# Suggested Setting:
# Remove Video Recording kernel extensions.
# Remove external iSight camera.
sudo srm -rf /System/Library/Extensions/Apple_iSight.kext
# Remove internal iSight camera.
sudo srm -rf /System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/AppleUSBVideoSupport.kext
# Remove Extensions cache files.
sudo touch /System/Library/Extensions
# Available Settings: # None
# Securing USB Support Software 
# ----------------------------- 
# Remove USB kernel extensions. # Default setting:
# kext files are installed and loaded.
# Suggested Setting:
sudo srm -rf /System/Library/Extensions/IOUSBMassStorageClass.kext # Remove Extensions cache files.
sudo touch /System/Library/Extensions
# Available Settings:
# None
# Securing FireWire Support Software 
# -----------------------------
# Default setting:
# kext files are installed and loaded.
# Suggested Setting:
# Remove FireWire kernel extensions. 
sudo srm -rf /System/Library/Extensions/IOFireWireSerialBusProtocolTransport.kext
# Remove Extensions cache files.
sudo touch /System/Library/Extensions
# Available Settings: # None
# Securing Global System Settings
# ------------------------------------------------------------------------- 
# Configuring EFI Settings
# ----------------------------------
# Default Setting:
# security-mode is off
# Suggested Setting:
# Secure startup by setting security-mode. Replace $mode-value with # “command” or “full.”
sudo nvram security-mode=”$mode-value”
# Verify security-mode setting.
sudo nvram -x -p
# Available Settings: # security-mode:
# “command”
# “full”
# Use the following command to view the current nvram settings:
# $ nvram -x -p
# Use the following commands to view nvram options:
# $ nvram -h
# or
# $ man nvram
# Enabling Access Warning for the Login Window
# ----------------------------------
# Create a login window access warning.
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText “Warning Text”
# You can also used the BannerSample project to create an access warning.
# Enabling Access Warning for the Command Line
# ----------------------------------
# Create a command-line access warning.
sudo touch /etc/motd
sudo chmod 644 /etc/motd
sudo echo “Warning Text” >> /etc/motd
# -------------------------------------------------------------------
# Securing System Preferences
# -------------------------------------------------------------------
# Securing MobileMe Preferences
# -------------------------
# Default Setting:
# If a MobileMe account is entered during setup, MobileMe is configured # for that account.
# Use the following command to display current MobileMe settings:
# $ defaults -currentHost read com.apple.<Preferenceidentifier>
# Use the following command to view all current settings for currenHost: # $ defaults -currentHost read
# Suggested Setting:
#Disable Sync options.
sudo defaults -currentHost write com.apple.DotMacSync ShouldSyncWithServer 1 # Disable iDisk Syncing.
sudo defaults -currentHost write com.apple.idisk $USER_MirrorEnabled -bool no
# Available Settings: # None
# Securing Accounts Preferences
# -----------------------------
# Change an account’s password.
# Don’t use the following command on a computer that might have
# other users logged in simultaneously.
sudo dscl . passwd /Users/$User_name $Oldpass $Newpass
# Make sure there is no password hint set.
sudo defaults write /Library/Preferences/com.apple.loginwindow RetriesUntilHint -int 0
# Set the login options to display name and password in the login window.
sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME
     -bool yes
# Disable Show the Restart, Sleep, and ShutDown Buttons.
sudo defaults write /Library/Preferences/com.apple.loginwindow PowerOffDisable -bool yes
# Disable fast user switching.
sudo defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool NO
# Securing Appearance Preferences 
# ----------------------------- 
# Default Setting:
# MaxAmount 10
# Suggested Setting:
# Disable display of recent applications.
sudo defaults write com.apple.recentitems Applications -dict MaxAmount 0
# Available Settings:
# MaxAmount 0,5,10,15,20,30,50
# Securing Bluetooth Preferences 
# ----------------------------- 
# Default Setting:
# Turn Bluetooth on.
# Suggested Setting:
# Turn Bluetooth off.
sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0
# Available Settings: # 0 (OFF) or 1 (On)
# Securing CDs & DVDs Preferences
# -----------------------------
# Default Setting:
# Preference file non existent: /Library/Preferences/com.apple.digihub # Blank CD: "Ask what to do"
# Blank DVD: "Ask what to do"
# Music CD: "Open iTunes"
# Picture CD: "Open iPhoto"
# Video DVD: "Open DVD Player"
# Suggested Setting:
# Disable blank CD automatic action.
sudo defaults write /Library/Preferences/com.apple.digihub com.apple.digihub.blank.cd.appeared -dict action 1
# Disable music CD automatic action.
sudo defaults write /Library/Preferences/com.apple.digihub com.apple.digihub.cd.music.appeared -dict action 1
# Disable picture CD automatic action.
sudo defaults write /Library/Preferences/com.apple.digihub com.apple.digihub.cd.picture.appeared -dict action 1
# Disable blank DVD automatic action.
sudo defaults write /Library/Preferences/com.apple.digihub com.apple.digihub.blank.dvd.appeared -dict action 1
# Disable video DVD automatic action.
sudo defaults write /Library/Preferences/com.apple.digihub com.apple.digihub.dvd.video.appeared -dict action 1
# Available Settings:
# action 1 = "Ignore"
# action 2 = "Ask what to do"
# action 5 = "Open other application" # action 6 = "Run script"
# action 100 = "Open Finder"
# action 101 = "Open itunes"
# action 102 = "Open Disk Utility"
# action 105 = "Open DVD Player"
# action 106 = "Open iDVD"
# action 107 = "Open iPhoto"
# action 109 = "Open Front Row"
# Securing Date & Time Preferences 
# -----------------------------
# Default Setting:
# NTP Server: time.apple.com
# Time Zone: Set time zone automatically using current location
# Suggested Setting:
# Set the NTP server.
### sudo cat >> /etc/ntp.conf << END server time.apple.com END # Set the date and time.
sudo systemsetup -settimezone $Time_Zone

# Available Settings:
# NTP Server: Any valid NTP server # Time Zone: /usr/share/zoneinfo
# Securing Desktop & Screen Saver Preferences 
# -----------------------------
# Default Setting:
# None
# Suggested Setting:
# Set idle time for screen saver. Replace XX with the idle time in seconds. sudo defaults -currentHost write com.apple.screensaver idleTime -int XX
# Set host corner to activate screen saver.
sudo defaults write /Library/Preferences/com.apple.dock.wvous-corner_code- corner -int 5
# Set modifier key to 0 wvous-corner_code-modifier
sudo defaults write /Library/Preferences/com.apple.dock.wvous-corner_code- modifier -int 0
# Available Settings:
# Corner options:
# wvous-bl-corner (bottom-left) # wvous-br-corner(bottom-right) # wvous-tl-corner (top-left)
# wvous-tr-corner (top-right)
# Securing Dock Preferences
# ----------------------------- # Default Setting:
# None
# Suggested Setting:
# Automatically hide and show Dock.
sudo defaults write /Library/Preferences/com.apple.dock autohide -bool YES
# Available Settings: # autohide -bool YES # autohide -bool NO
# Securing Energy Saver Preferences # -----------------------------
# Default Setting:
# None
# Suggested Setting:
# Disable computer sleep.
sudo pmset -a sleep 0
# Enable hard disk sleep.
sudo pmset -a disksleep 1
# Disable Wake for Ethernet network administrator access. sudo pmset -a womp 0
# Disable Restart automatically after power failure. sudo pmset -a autorestart 0
# Available Settings: # 0 (OFF) or 1 (ON)
# Securing Exposé & Spaces Preferences # -----------------------------
# Default Setting:
# Enabled
# Suggested Setting:
# Disable dashboard.
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.dashboard.advisory.fetch.plist
# Available Settings: # Enabled or Disabled
# Securing Network Preferences # ----------------------------- # Default Setting:
# Enabled
# Suggested Setting:
# Disable IPv6.
sudo networksetup -setv6off $interface
# Available Settings:
# The interface value can be AirPort, Bluetooth, Ethernet, or FireWire.
# Securing Print & Fax Preferences # -----------------------------
# Default Setting:
# Disabled
# Suggested Setting:
# Disable the receiving of faxes.
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.efax.plist # Disable printer sharing.
sudo cp /etc/cups/cupsd.conf $TEMP_FILE
if /usr/bin/grep "Port 631" /etc/cups/cupsd.conf
then
     usr/bin/sed "/^Port 631.*/s//Listen localhost:631/g" $TEMP_FILE > /etc/
     cups/cupsd.conf
else
echo "Printer Sharing not on"
fi
# Available Settings: # Enabled or Disabled
# Securing Security Preferences
# -----------------------------
# Default Setting:
# Required Password Wake: Disabled # Automatic Login: Disabled
# Password Unlock Preferences: Disabled
# Secure Virtual Memory is Enabled on Portable computer and is Disabled
# on Desktop computers.
# IR remote control: Enabled
# FileVault: Disabled
# Suggested Setting:
# Enable Require password to wake this computer from sleep or screen saver. sudo defaults -currentHost write com.apple.screensaver askForPassword -int 1 # Disable Automatic login.
sudo defaults write /Library/Preferences/.GlobalPreferences\ com.apple.userspref.DisableAutoLogin -bool yes
# Require password to unlock each System Preference pane.
# Edit the /etc/authorization file using a text editor.
# Find <key>system.preferences<key>.
# Then find <key>shared<key>.
# Then replace <true/> with <false/>.
# Disable automatic login.
sudo defaults write /Library/Preferences/.GlobalPreferences com.apple.autologout.AutoLogOutDelay -int 0
# Enable secure virtual memory.
sudo defaults write /Library/Preferences/com.apple.virtualMemory UseEncryptedSwap -bool yes
# Disable IR remote control.
sudo defaults write /Library/Preferences/com.apple.driver.AppleIRController DeviceEnabled -bool no
# Enable FileVault.
# To enable FileVault for new users, use this command.
sudo /System/Library/CoreServices/ManagedClient.app/Contents/Resources/createmobileaccount
# Enable Firewall.
# Replace value with
# 0 = off
# 1 = on for specific services
# 2 = on for essential services
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int value
# Enable Stealth mode.
sudo defaults write /Library/Preferences/com.apple.alf stealthenabled 1
# Enable Firewall Logging.
sudo defaults write /Library/Preferences/com.apple.alf loggingenabled 1
# Securing System Swap and Hibernation Storage
# -----------------------------
# Default Setting:
# Secure Virtual Memory on Portable computers is Enabled and is Disabled on # Desktop computers.
# Suggested Setting:
# Enable secure virtual memory.
sudo defaults write /Library/Preferences/com.apple.virtualMemory UseEncryptedSwap -bool YES
# Available Setting:
# UseEncryptedSwap -bool NO
# UseEncryptedSwap -bool YES
# You can also turn hibernate off by using the following command: # sudo pmset hibernatemode 0
# Securing Sharing Preferences # ----------------------------- # Default Setting:
# $host_name = User’s Computer
# Suggested Setting:
# Change computer name where $host_name is the name of the computer. sudo systemsetup -setcomputername $host_name
# Change computer Bonjour host name.
sudo scutil --set LocalHostName $host_name
# Available Setting:
# The host name cannot contain spaces or other non-DNS characters. # Securing Software Updates Preferences
# -----------------------------
# Default Setting:
# Check for Updates: Enabled
# Check Updates: Weekly
# Suggested Setting:
# Disable check for updates and Download important updates automatically. sudo softwareupdate --schedule off
# Available Setting:
# Check for Updates: Enabled or Disabled # Check Updates: Daily, Weekly, Monthly
# Securing Sound Preferences
# -----------------------------
# Default Setting:
# Internal microphone or line-in: Enabled
# Suggested Setting:
# Disable internal microphone or line-in.
# This command does not change the input volume for input devices. It # only sets the default input device volume to zero.
sudo osascript -e "set volume input volume 0"
# Available Setting:
# Internal microphone or line-in: Enabled or Disabled
# Securing Speech Preferences 
# ----------------------------- 
# Default Setting:
# Speech Recognition: Disabled 
# Text to Speech: Enabled
# Suggested Setting:
# Disable Speech Recognition.
sudo defaults write "com.apple.speech.recognition.AppleSpeechRecognition.prefs" StartSpeakableItems -bool false
# Disable Text to Speech settings.
sudo defaults write "com.apple.speech.synthesis.general.prefs" TalkingAlertsSpeakTextFlag -bool false
sudo defaults write "com.apple.speech.synthesis.general.prefs" SpokenNotificationAppActivationFlag -bool false
sudo defaults write "com.apple.speech.synthesis.general.prefs" SpokenUIUseSpeakingHotKeyFlag -bool false
sudo defaults delete "com.apple.speech.synthesis.general.prefs" TimeAnnouncementPrefs
# Available Setting:
# Each item can be set to ON or OFF: # OFF: -bool false
# ON: -bool true
# Securing Spotlight Preferences # ----------------------------- # Default Setting:
# ON for all volumes
# Suggested Setting:
# Disable Spotlight for a volume and erase its current meta data, where # $volumename is the name of the volume.
sudo mdutil -E -i off $volumename
# Available Setting:
# Spotlight can be turned ON or OFF for each volume.
# Securing Startup Disk Preferences # -----------------------------
# Default Setting:
# Startup Disk = "Macintosh HD"
# Suggested Setting:
# Set startup disk.
sudo systemsetup -setstartupdisk $path
# Available Setting:
# Startup Disk = Valid Boot Volume
# Securing Time Machine Preferences # -----------------------------
# Default Setting:
# OFF
# Suggested Setting:
# Enable Time Machine.
sudo defaults write /Library/Preferences/com.apple.TimeMachine AutoBackup 1
# Available Setting: # 0 (OFF) or 1 (ON)
# Securing Universal Access Preferences # -----------------------------
# Default Setting:
# OFF
# Suggested Setting:
# Disable VoiceOver service.
launchctl unload -w /System/Library/LaunchAgents/com.apple.VoiceOver.plist launchctl unload -w /System/Library/LaunchAgents/com.apple.ScreenReaderUIServer.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.scrod.plist
# Available Setting: # None
# -------------------------------------------------------------------
# Securing Applications
# -------------------------------------------------------------------
# Disabling iSync
# ----------------------------- # Default Setting:
# OFF
# Suggested Setting:
# Disable iSync.
launchctl unload -w /System/Library/LaunchAgents/com.apple.syncservices.SyncServer.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.syncservices.uihandler.plist
# Available Setting: # None
# -------------------------------------------------------------------
# Securing Network Services
# -------------------------------------------------------------------
# Disabling IKE VPN Key Management Service
# ----------------------------- # Default Setting:
# OFF
# Suggested Setting:
# If a VPN is not used, disable the IKE VPN key management service. s
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.racoon.plist
# Available Setting: # None
# Block Bonjour listening 
# ------------------------- 
# Default Setting:
# Bonjour is enabled.
# Firewall is disabled.
# Suggested Setting:
# Reload the firewall rules. sudo /sbin/ipfw flush
# Available Settings:
# Disable firewall and allow Bonjour. # Enable firewall and block port 5353.
# Enable Bonjour Service
# ------------------------- 
# Default Setting:
# Bonjour is enabled
# Firewall is disabled
# Suggested Setting:
# Remove the following line from /etc/ipfw.conf. add 00001 deny udp from any to me dst-port 5353 # Reload the firewall rules
sudo /sbin/ipfw flush
# Available Settings:
# Disable Firewall and allow Bonjour # Enable Firewall and block port 5353
# DVD or CD Sharing
# ------------------------- 
# Default Setting:
# Disabled (unload)
# Suggested Setting:
# Disable DVD or CD Sharing.
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.ODSAgent.plist
# Available Settings: # Disabled (unload) # Enabled (load)
# Screen Sharing (VNC)
# ------------------------- 
# Default Setting:
# Disabled
# Suggested Setting:
# Disable Screen Sharing.
sudo srm /private/etc/ScreenSharing.launchd
# Available Settings: # Enabled:
# "All Users"
# "Only these users"
# Disable File Sharing services. 
# -------------------------
# Default Setting:
# File Sharing Disabled:
# AFP
# FTP
# SMB
# NFS
# Suggested Setting:
# Disable FTP.
sudo launchctl unload -w /System/Library/LaunchDaemons/ftp.plist # Disable SMB.
sudo defaults delete /Library/Preferences/SystemConfiguration/com.apple.smb.server EnabledServices
sudo launchctl unload -w /System/Library/LaunchDaemons/nmbd.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/smbd.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.smb.server.preferences.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.smb.sharepoints.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.smbfs_load_kext.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/org.samba.winbindd.plist
# Disable AFP.
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.AppleFileServer.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.afpfs_afpLoad.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.afpfs_checkafp.plist
# Disable NFS
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.nfsd.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.lockd.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.statd.notify.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.portmap.plist
# Available Settings: # Disabled (unload) # Enabled (load)
# Web Sharing
# ----------------------------- 
# Default Setting:
# Web Services: Disabled
# Suggested Setting:
# Disable Web Sharing.
sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist
# Available Settings: 
# Web Services: Disabled
# Enabled
# Remote Login (SSH)
# ----------------------------- 
# Default Setting:
# Remote Login (SSH): Disabled
# Suggested Setting:
# Disable Remote Login.
sudo launchctl unload -w /System/Library/LaunchDaemons/ssh.plist
# Available Settings: # Remote Login (SSH): # Disabled
# Enabled
# Remote Management (ARD)
# ----------------------------- 
# Default Setting:
# Remote Management: Disabled
# Suggested Setting:
# Disable Remote Management.
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -stop
# Available Settings: 
# Remote Management: 
# Disabled
# Enabled
# Remote Apple Events (RAE)
# ----------------------------- 
# Default Setting:
# Remote Apple Events: Disabled
# Suggested Setting:
# Disable Remote Apple Events.
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.eppc.plist
# Available Settings: 
# Remote Apple Events: 
# Disabled
# Enabled
# Xgrid Sharing
# ----------------------------- 
# Default Setting:
# Xgrid Sharing: Disabled
# Suggested Setting:
# Disable Xgrid Sharing.
sudo launchctl unload -w /System/Library/Daemons/com.apple.xgridagentd 
sudo launchctl unload -w /System/Library/Daemons/com.apple.xgridcontrollerd
# Available Settings: 
# Xgrid Sharing:
# Disabled
# Enabled
# Internet Sharing
# ----------------------------- 
# Default Setting:
# Internet Sharing: Disabled
# Suggested Setting:
# Disable Internet Sharing.
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.nat NAT -dict Enabled -int 0
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.InternetSharing.plist
# Available Settings: 
# Internet Sharing: 
# Disabled
# Enabled
# Bluetooth Sharing
# ----------------------------- 
# Default Setting:
# Bluetooth Sharing: Disabled
# Suggested Setting:
# Disable Bluetooth Sharing.
sudo defaults -currentHost write com.apple.bluetooth PrefKeyServicesEnabled 0
# Available Settings: # Bluetooth Sharing: # Disabled
# Enabled
# Understanding and Managing Daemons and Agents 
# -----------------------------
# Default Setting:
# Bluetooth Sharing: off
# Suggested Setting:
# Turn off AirPort Services using the following commands. Run the last sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.airportPrefsUpdater.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.AirPort.wps.plist
sudo launchctl unload -w /System/Library/LaunchAgents/com.apple.airportd.plist
# Turn off remote control service using the following command:
sudo launchctl unload -w /System/Library/LaunchAgents/com.apple.RemoteUI
# Turn off Screen Sharing services.
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.RFBEventHelper.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.RFBRegisterMDNS_RemoteManagement.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.RFBRegisterMDNS_ScreenSharing.plist
sudo launchctl unload -w /System/Library/LaunchAgents/com.apple.ScreenSharing.plist
# Turn off Remote Management service using the following commands:
sudo launchctl unload -w /System/Library/LaunchAgents/com.apple.RemoteDesktop.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.RemoteDesktop.PrivilegeProxy.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.RFBEventHelper.plist
# Turn off Bluetooth service using the following command:
sudo launchctl unload -w /System/Library/LaunchDaemons/om.apple.blued.plist
# Available Settings: 
# Disabled (unload) 
# Enabled (load)










