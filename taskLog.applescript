on run argv
	set theResult to ""
	set theEarliest to date (item 1 of argv)
	# set theEarliest to date "Thursday, May 23, 2013 12:00:00 AM"
	set theLatest to theEarliest + 1 * days
	tell application "Tictoc"
		
		set theTaskList to properties of every task
		repeat with theTask in tasks
			set theTimeSpent to 0
			repeat with theSession in sessions of theTask
				set theStart to start date of theSession
				set theEnd to end date of theSession
				if theStart < theLatest and theEnd > theEarliest then
					if theStart < theEarliest then
						set theStart to theEaliest
					end if
					if theEnd > theLatest then
						set theEnd to theLatest
					end if
					set theTimeSpent to theTimeSpent + (theEnd - theStart)
				end if
			end repeat
			if theTimeSpent > 0 then
				set theResult to theResult & "	" & my formatTime(theTimeSpent) & "	" & name of theTask & "
"
			end if
		end repeat
		
	end tell
	return theResult as string
end run

to formatTime(theSeconds)
	set theHours to (theSeconds div hours)
	set theRemainderSeconds to (theSeconds mod hours)
	set theMinutes to (theRemainderSeconds div minutes)
	if theHours > 0 and theMinutes > 0 then
		return theHours & "h " & theMinutes & "m"
	end if
	if theHours > 0 then
		return theHours & "h"
	end if
	return theMinutes & " m"
end formatTime
