global wowInstances
# PUT ALL YOUR ACCOUNTS HERE IN THE DICTIONARY
set wowInstances to {{account:"your@account.email", pid:false}, {account:"your@another_account.email", pid:false}}

set wowAccounts to {}
repeat with instance in wowInstances
	set end of wowAccounts to account of instance
end repeat

set accountsToStart to {}
repeat until accountsToStart is false
	set accountsToStart to choose from list wowAccounts with prompt "Choose an account to start:" with multiple selections allowed
	repeat with account in accountsToStart
		startWow for account
	end repeat
end repeat


to startWow for account
	login for account on (runWowProcess for account)
end startWow

to runWowProcess for account
	set pid to getPid for account
	tell application "System Events"
		if pid is not false and ((first process whose unix id is pid) exists) then
			do shell script "kill -9 " & pid
		end if
	end tell
	set pid to (do shell script "/usr/bin/open -n -a 'World of Warcraft Classic' && pgrep -n 'World of Warcraft Classic'")
	updatePid for account to pid
	return pid
end runWowProcess

to login for account on pid
	tell application "System Events"
		repeat until (exists (first window of (first process whose unix id is pid)))
			delay 0.5
		end repeat
		tell (first process whose unix id is pid)
			activate
			set frontmost to true
			set frontWindow to first window
			set area to {position, size} of first window
			clickInside of me over area at {0.5, 0.81}
			keystroke account & tab & (do shell script "security find-generic-password -s wowx -a " & account & " -w") & return
		end tell
	end tell
end login

to clickInside over {{areaLeft, areaTop}, {areaWidth, areaHeight}} at {xRatio, yRatio}
	local x, y
	set x to areaLeft + areaWidth * xRatio
	set y to areaTop + areaHeight * yRatio
	do shell script "/usr/local/bin/cliclick c:" & (round x) & "," & (round y)
end clickInside

to updatePid for accountToUpdate to newPid
	repeat with instance in wowInstances
		if (account of instance as string) is equal to (accountToUpdate as string) then
			set pid of instance to newPid
		end if
	end repeat
end updatePid

to getPid for accountToGet
	set pidOfAccount to false
	repeat with instance in wowInstances
		if (account of instance as string) is equal to (accountToGet as string) then
			set pidOfAccount to pid of instance
		end if
	end repeat
	return pidOfAccount
end getPid