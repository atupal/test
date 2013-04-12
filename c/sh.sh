	#!/usr/bin/bash
	FPATH="/usr/local/functions/shellcurses"
	
	initscr
	SCRWID="${MAX_COLS}"
	SCRLEN="${MAX_LINES}"
	clear
	
	#### Display a two line header, centered on the screen
	HEADER1="Shell Curses Example 5"
	HEADER2="Data Entry Screen"
	mvaddstr 1 $(( ( SCRWID - ${#HEADER1} ) / 2 )) "${HEADER1}"
	mvaddstr 2 $(( ( SCRWID - ${#HEADER2} ) / 2 )) "${HEADER2}"
	
	#### Define the user entry prompts
	DOTS="........................................"
	PRMPT[1]="Enter an existing directory name"
	PRMPT[2]="Enter an existing regular file name"
	PRMPT[3]="Enter an alpha-numeric value"
	PRMPT[4]="Enter a numeric value"
	PRMPT[5]="Enter an executable file name"
	PCNT="${#PRMPT[@]}"
	
	#### Display the numbered data entry prompt with trailing dots
	for IDX in "${!PRMPT[@]}"
	do
	    (( DOTWID = ( SCRWID / 2 ) - ( ${#PRMPT[IDX]} + 4 ) ))
	    PRMPT[IDX]="${PRMPT[IDX]}${DOTS:0:${DOTWID}}"
	    mvaddstr $(( IDX + 4 )) 2 "${IDX}: ${PRMPT[IDX]}...:"
	done
	DATACOL="$(( ${#PRMPT[1]} + 10 ))"
	
	#### Prompt the user for a selection
	mvaddstr $(( SCRLEN - 3 )) 2 "Select a line number to enter data:"
	
	#### Read the users data line number selection from the screen
	while :
	do
	#### Read the line number entered by the user
	    mvclrtoeol $(( SCRLEN - 3 )) 40
	    refresh
	    ANS="$( getstr )"
	
	#### clear the status line and re-display the default status message
	    mvclrtoeol $(( SCRLEN - 2 )) 2
	    mvaddstr $(( SCRLEN - 2 )) 2 "( 0 = Exit )"
	
	#### Validate the user entered line number, if invalid go back and ask again
	    [[ "_${ANS}" == "_0" ]] && exit 0
	    if [[ "_${ANS}" != _+([[:digit:]]) ]] || (( ANS < 1 )) || (( ANS > PCNT ))
	    then
	        continue
	    fi
	
	#### Read the line data from the user entry
	    mvclrtoeol $(( ANS + 4 )) ${DATACOL}
	    refresh
	    DATA[${ANS}]="$( getstr )"
	
	    mvclrtoeol $(( SCRLEN - 2 )) 2
	    attrset rev
	
	#### Check the validity of the line 1 data as entered by the user
	    if (( ANS == 1 )) && [[ ! -d "${DATA[${ANS}]}" ]]
	    then
	        mvclrtoeol $(( ANS + 4 )) ${DATACOL}
	        mvaddstr $(( SCRLEN - 2 )) 2 "ERROR: Invalid Directory Name"
	    fi
	
	#### Check the validity of the line 2 data as entered by the user
	    if (( ANS == 2 )) && [[ ! -f "${DATA[${ANS}]}" ]]
	    then
	        mvclrtoeol $(( ANS + 4 )) ${DATACOL}
	        mvaddstr $(( SCRLEN - 2 )) 2 "ERROR: Invalid Regular File Name"
	    fi
	
	#### Check the validity of the line 3 data as entered by the user
	    if (( ANS == 3 )) && [[ "_${DATA[${ANS}]}" != _+([[:alnum:]]) ]]
	    then
	        mvclrtoeol $(( ANS + 4 )) ${DATACOL}
	        mvaddstr $(( SCRLEN - 2 )) 2 "ERROR: Invalid Alpha-Numeric Value"
	    fi
	
	#### Check the validity of the line 4 data as entered by the user
	    if (( ANS == 4 )) && [[ "_${DATA[${ANS}]}" != _+([[:digit:]]) ]]
	    then
	        mvclrtoeol $(( ANS + 4 )) ${DATACOL}
	        mvaddstr $(( SCRLEN - 2 )) 2 "ERROR: Invalid Numeric Value"
	    fi
	
	#### Check the validity of the line 5 data as entered by the user
	    if (( ANS == 5 )) && [[ ! -x "${DATA[${ANS}]}" ]]
	    then
	        mvclrtoeol $(( ANS + 4 )) ${DATACOL}
	        mvaddstr $(( SCRLEN - 2 )) 2 "ERROR: File is not executable or 
             does not exist"
	    fi
	    attroff
	    refresh
	
	done
	
	endwin
	
	exit ${ANS}
