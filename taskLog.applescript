on run argv
	set theResult to "| Time | Task |
| -----: | ----- |
"
	set theEarliest to date (item 1 of argv)
	set theLatest to theEarliest + 1 * days
	tell application "Tictoc"
	
        set theTotal to 0
		set theTaskList to properties of every task
		repeat with theTask in tasks
			set theTimeSpent to 0
			repeat with theSession in sessions of theTask
				set theStart to start date of theSession
				set theEnd to end date of theSession
				if theStart < theLatest and theEnd > theEarliest then
					if theStart < theEarliest then
						set theStart to theEarliest
					end if
					if theEnd > theLatest then
						set theEnd to theLatest
					end if
					set theTimeSpent to theTimeSpent + (theEnd - theStart)
				end if
			end repeat
			if theTimeSpent > 0 then
                set theTotal to theTotal + theTimeSpent
                set theResult to theResult & my formatRow(theTask, theTimeSpent)
			end if
		end repeat
		
	end tell
    set theResult to theResult & formatTotal(theTotal)
	return theResult as string
end run

to formatRow(theTask, theSeconds)
    return "| " & my formatTime(theSeconds) & " | " & name of theTask & "|
"
end formatRow

to formatTotal(theSeconds)
    return "| **" & formatTime(theSeconds) & "** ||
"
end formatTime

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
