on settings()
	global theDiskImage
	global theApp
	global volumeName
	set theDiskImage to "OS 9 SSD:Games:Deus Ex:Deus Ex No CD.img" as alias
	set volumeName to "Deus Ex"
	set theApp to "OS 9 SSD:Games:Deus Ex:Deus Ex" as alias
	set appName to getappName(theApp)
end settings
---

on getappName(appPath)
	set oldDelims to AppleScript's text item delimiters
	set AppleScript's text item delimiters to ":"
	set theResult to (the last text item of (appPath as string))
	set AppleScript's text item delimiters to oldDelims
	return theResult
end getappName

--set screenSettings to {screen size:{640, 480}, color depth:8}


on checkDock()
	--Check to see if A-Dock is running. If so, remember it and then quit A-Dock.
	tell application "Finder"
		if exists process "A-Dock" then
			return true
		else
			return false
		end if
	end tell
end checkDock


on mountImage(theImage)
	tell application "Finder"
		open theImage --Mount the CD image
	end tell
end mountImage


on setScreens(screenSize)
	«event JonsScrC» screenSize --Set the display resolution and color depth
end setScreens


on runApp(theApp)
	tell application "Finder"
		open theApp --Launch app
	end tell
end runApp

on waitUntilQuit(waitApp)
	--Watch for app to quit
	set appRunning to true
	repeat until appRunning is false
		tell application "Finder"
			if exists process waitApp then
				set appRunning to true
			else
				set appRunning to false
			end if
		end tell
	end repeat
end waitUntilQuit



on main()
	settings()
	--  Screen Settings   --
	set currentScreenSettings to «event JonsScrL» given «class for »:«constant ScrSMain» --Store current display settings
	global theDiskImage
	global theApp
	global volumeName
	set aDockRunning to checkDock()
	if aDockRunning is true then
		tell application "A-Dock Control" to quit
	end if
	--	set diskList to list disks
	mountImage(theDiskImage)
	--	set screens to screenSettings
	runApp(theApp)
	waitUntilQuit(getappName(theApp))
	--	set screens to currentScreenSettings --Revert to original display settings
	
	--Relaunch A-Dock if it was running before.
	if aDockRunning is true then
		tell application "A-Dock Control"
			activate
		end tell
	end if
	
	--Eject the CD image:
	tell application "Finder" to eject disk volumeName
	
	
end main
main()
on quit {}
	global aDockRunning, volumeName
	--	set screens to currentScreenSettings --Revert to original display settings
	
	--Relaunch A-Dock if it was running before.
	if aDockRunning is true then
		tell application "A-Dock Control"
			activate
		end tell
	end if
	
	--Eject the CD image:
	tell application "Finder" to eject disk volumeName
	
end quit
