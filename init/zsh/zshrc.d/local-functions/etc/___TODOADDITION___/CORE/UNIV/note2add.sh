#!/bin/bash
# The latest version of the script can be found at
# https://github.com/egalion/note2add
## This is the notes directory. Change it to suit your needs.
NOTES2ADD_DIR="$HOME"/tn


fn_edit () { # function to edit the file
tempfile="$NOTES2ADD_DIR/temp.tmp"
var_notetitle=$(sed -n '/^t_itl_e/p' "$n")
var_notetags=$(sed -n '/^tt_a_gg/p' "$n")

sed -n '/^t_itl_e.*$/,/^tt_a_gg/{//!p}' "$n" > "$tempfile"
    "${EDITOR:-nano}" "$tempfile"
    { echo "$var_notetitle" > "$n"
      echo >> "$n"
      cat "$tempfile" >> "$n"
      echo >> "$n"
      echo "$var_notetags" >> "$n" ;
    }
    rm "$tempfile"
} # function to edit the file

fn_file_action () { # function to view, edit or delete file

while :
do
echo        
echo    You have selected \""$n"\".
echo        
echo 	What to do with the file?
echo	Make your choice and press Enter.
echo    
echo	\"1\" or \"q\" to quit
echo 	\"2\" or \"v\" to view
echo 	\"3\" or \"e\" to edit
echo 	\"delete\" to delete
echo
read var_action
  case "$var_action" in
    "1" ) 
          echo Back to menu...
          sleep 1
          break;;
    "q" ) 
          echo Back to menu...
          sleep 1
          break;;
    "2" ) 
          echo Showing \""$n"\" ...
          sleep 1
          echo "$var_note2show" | less;;
    "v" ) 
          echo Showing \""$n"\" ...
          sleep 1
          echo "$var_note2show" | less;;
    "3" ) 
          echo Opening \""$n"\" for edit ...
          sleep 1
          fn_edit
          break;;
    "e" )
          echo Opening \""$n"\" for edit ...
          sleep 1
          fn_edit
          break;;
    "delete" ) 
          echo Deleting \""$n"\" ...
          sleep 1
          rm "$n"
          echo "\"$n"\" deleted.
          break;;
    "q" ) break;;
  esac
done
} # function to view, edit, or delete the file


fn_note2add () { # function to add a note

## Create array with selection options
## where to create the note.

cd "$NOTES2ADD_DIR"

var_dirchoice=("_exit_" "_make_dir_" "_current_dir_" */)

echo
echo "Choose the directory for your note." 
echo "Option 1) will exit the program."
echo "Option 2) will create a new directory first." 
echo "Option 3) will create the note in the root directory."
echo "If you see 4) */ you have no directories in root."
echo
select d in "${var_dirchoice[@]}"
do 
if [ -z "$d" ]
  then
  echo Invalid selection. Choose a number between 1 and ${#var_dirchoice[@]}.
elif [[ "$d" == ${var_dirchoice[0]} ]]
  then
  exit
elif [[ "$d" == ${var_dirchoice[1]} ]]
  then
  echo "Write the name of the directory bellow."
  echo "Keep it short and use only" 
  echo "letters, spaces, dashes, and numbers."
  read var_newdirname 
  mkdir "$var_newdirname"
  cd "$var_newdirname"
  break
elif [[ "$d" == ${var_dirchoice[2]} ]]
  then
  echo "Creating note in the root directory..."
  cd ./
  break
elif [[ "$d" == "*/" ]]
  then
  echo "You have no directories. Choose option 1), 2) or 3)."
else
  echo You have selected "$d". Creating the note there...
  cd "$d"
  break
fi
done

## Now add the title, the content and the tags of the note.

echo
echo "Write the title of your note here."
echo "Use letters, dashes, numbers, spaces, commas, and dots."
echo
while :
do
  read var_notetitle
  echo
  if [ -z "$var_notetitle" ]
    then
    echo
    echo "You can't leave it blank. Try again. Type "exit" to exit."
    echo
  elif [ -e "$var_notetitle".txt ]
    then
    echo
    echo Note exists. Please, choose another name, or type "exit" to exit.
    echo
  elif [ "$var_notetitle" = "exit" ]
    then
    break
  else
    "${EDITOR:-nano}" "$tempfile"
      { echo t_itl_e: "$var_notetitle" > "$var_notetitle".txt
	echo >> "$var_notetitle".txt
	cat "$tempfile" >> "$var_notetitle".txt 
	echo >> "$var_notetitle".txt 
	rm "$tempfile" ;
      }
    echo TAGS LIST:
    echo $(grep -Er --include='*.txt' "^tt_a_gg" "$NOTES2ADD_DIR" | cut -d ":" -f3 | sort | uniq | tr '\n' ';')
    echo
    echo "Existing tags shown above."
    echo "Insert tags. Enter tag and press Enter. Leave blank and press Enter to finish."
    echo
    while :
    do
      read var_tag
      if [ -z "$var_tag" ]
	then
	echo
	echo "Note added."
	echo
	break
      else
	echo tt_a_gg: "$var_tag" >> "$var_notetitle".txt
      fi
    done
    break
  fi
done
} # function to add a note


fn_search_by_tag () { # function to search by tag

OLDIFS=$IFS
IFS=$'\n' 

cd "$NOTES2ADD_DIR"

echo
echo TAGS LIST:
echo $(grep -Er --include='*.txt' "^tt_a_gg" "$NOTES2ADD_DIR" | cut -d ":" -f3 | sort | uniq | tr '\n' ';')
echo
echo Search by tags.
echo "Write your tags here (maximum 3 tags)."
echo Add tag1 and press enter or leave blank and you will exit search.
echo You can see existing tags above.
echo
read var_tag1
if [ -z "$var_tag1" ] # open: tag1 is 0?
  then
  echo  
  echo "No tag supplied. Exiting search..."
  echo
else # tag1 is (not) 0?
  echo 
  echo TAGS LIST: 
  echo $(grep -Er --include='*.txt' "^tt_a_gg" "$NOTES2ADD_DIR" | cut -d ":" -f3 | sort | uniq | tr '\n' ';')
  echo
  echo Add tag2 and press enter or leave blank and you will search using tag1. 
  echo You can see existing tags above.
  echo
  read var_tag2
  if [ -z "$var_tag2" ] # open: tag2 is 0? YES
    then
    echo
    echo Showing notes tagged with \""$var_tag1"\":
    echo
    var_searchnote=("Exit_search" "Show content of all notes" $(grep -Erl --include='*.txt' "tt_a_gg: "$var_tag1"" | sort))
    if [ "${#var_searchnote[@]}" -lt 3 ] # selection if there is a result for tag1 search
    then
    echo
    echo No results found.
    echo
    else
#######
    select n in "${var_searchnote[@]}"
    do # do for select with 1 tag
    if [ -z "$n" ] # open: selection in range of list with 1 tag?
      then
      echo Invalid selection. Choose a number between 1 and ${#var_searchnote[@]}.
    elif [ "$n" = "Exit_search" ]
      then
      break
    elif [ "$n" = "Show content of all notes" ]
      then
      var_notes2show=$(grep -Erl --include='*.txt' "tt_a_gg: "$var_tag1"" | sort | xargs -0 -d '\n' sed -n '/t_itl_e/,/tt_a_gg/p' | sed -e 's/t_itl_e/-----\nTITLE/;s/^tt_a_gg.*//') 
      echo
      echo Showing the content of all notes tagged with \""$var_tag1"\":
      echo
      echo "$var_notes2show" | less
      echo Press Enter
    else
      var_note2show=$(sed -n '/t_itl_e/,/tt_a_gg/p' "$n" | sed -e 's/t_itl_e/TITLE/;s/^tt_a_gg.*//')
      #echo "$var_note2show" | less
      fn_file_action
      echo Press Enter
    fi # close: selection in range of list with 1 tag
    done # done for selection with 1 tag 
########
    fi # selection if there is a result for tag1 search
  else # tag 2 is (not) 0?
    echo
    echo TAGS LIST:
    echo $(grep -Er --include='*.txt' "^tt_a_gg" "$NOTES2ADD_DIR" | cut -d ":" -f3 | sort | uniq | tr '\n' ';')
    echo
    echo Add tag3 and press enter or leave blank and you will search using tag1 and tag2.
    echo You can see existing tags above.
    echo
    read var_tag3
    if [ -z "$var_tag3" ] # open: tag 3 is 0?
      then
      echo
      echo Showing notes tagged \""$var_tag1"\" and \""$var_tag2"\":
      echo
      var_searchnote=("Exit_search" "Show content of all notes" $(grep -Erl --include='*.txt' "^tt_a_gg: "$var_tag1"" | xargs -0 -d '\n' grep -El "^tt_a_gg: "$var_tag2"" | sort))
      if [ "${#var_searchnote[@]}" -lt 3 ] # selection if there is a result for tag1 and tag2 search
      then
      echo
      echo No results found.
      echo
      else
      select n in "${var_searchnote[@]}"
      do # for select with 2 tags
      if [ -z "$n" ] # selection in range of list with 2 tags
        then
        echo Invalid selection. Choose a number between 1 and ${#var_searchnote[@]}.
      elif [ "$n" = "Exit_search" ]
        then
        break
      elif [ "$n" = "Show content of all notes" ]
        then
        var_notes2show=$(grep -Erl --include='*.txt' "^tt_a_gg: "$var_tag1"" | xargs -0 -d '\n' grep -El "^tt_a_gg: "$var_tag2"" | sort | xargs -0 -d '\n' sed -n '/t_itl_e/,/tt_a_gg/p' | sed -e 's/t_itl_e/-----\nTITLE/;s/^tt_a_gg.*//') 
        echo
        echo Showing the content of all notes tagged with \""$var_tag1"\" and \""$var_tag2"\":
        echo
        echo "$var_notes2show" | less
      else
        var_note2show=$(sed -n '/t_itl_e/,/tt_a_gg/p' "$n" | sed -e 's/t_itl_e/TITLE/;s/^tt_a_gg.*//')
        #echo "$var_note2show" | less
        fn_file_action
        echo Press Enter
      fi # selection in range for list of 2 tags
      done # done for select with 2 tags
      fi # selection if there is a result with tag1 and tag2 search
    else # tag 3 is (not) 0?
      echo
      echo Showing notes tagged \""$var_tag1"\", \""$var_tag2"\", and \""$var_tag3"\":
      echo
      var_searchnote=("Exit_search" "Show content of all notes" $(grep -Erl --include='*.txt' "tt_a_gg: "$var_tag1"" | xargs -0 -d '\n\' grep -El "tt_a_gg: "$var_tag2"" | xargs -0 -d '\n' grep -El "tt_a_gg: "$var_tag3"" | sort ))
      if [ "${#var_searchnote[@]}" -lt 3 ] # selection if there is a result for tag1 and tag2 search
      then
      echo
      echo No results found.
      echo
      else
      select n in "${var_searchnote[@]}"
# put do - done here: START
      do # do for select with 3 tags
      if [ -z "$n" ] # selection in range of list with 3 tags
        then
        echo Invalid selection. Choose a number between 1 and ${#var_searchnote[@]}.
      elif [ "$n" = "Exit_search" ]
        then
        break
      elif [ "$n" = "Show content of all notes" ]
        then
        var_notes2show=$(grep -Erl --include='*.txt' "^tt_a_gg: "$var_tag1"" | xargs -0 -d '\n' grep -El "^tt_a_gg: "$var_tag2"" | xargs -0 -d '\n' grep -El "^tt_a_gg: "$var_tag3"" | sort | xargs -0 -d '\n' sed -n '/t_itl_e/,/tt_a_gg/p' | sed -e 's/t_itl_e/-----\nTITLE/;s/^tt_a_gg.*//') 
        echo
        echo Showing the content of all notes tagged with \""$var_tag1"\", \""$var_tag2"\", and \""$var_tag3"\":
        echo
        echo "$var_notes2show" | less
        echo Press Enter
      else
        var_note2show=$(sed -n '/t_itl_e/,/tt_a_gg/p' "$n" | sed -e 's/t_itl_e/TITLE/;s/^tt_a_gg.*//')
        #echo "$var_note2show" | less
        fn_file_action
        echo Press Enter
      fi # close: selection in range of list with 3 tags
      done # done for select with 3 tags
# do - done here: END
      fi # selection if there is a result with tag1, tag2, and tag3 search
    fi # close: tag3 is 0?
  fi # close: tag2 is 0?
fi # close: tag1 is 0?

IFS=$OLDIFS
} # function to search by tag


fn_search_in_title () { # function to search in title

cd "$NOTES2ADD_DIR"

OLDIFS=$IFS
IFS=$'\n'

echo
echo Write keyword1 here. Leave blank and press Enter to cancel search.
echo
read var_keyword1
if [ -z "$var_keyword1" ]
  then
  echo "No keyword. Exiting."
else 
  echo
  echo Write keyword2 here. Leave blank and press Enter to search only with \""$var_keyword1"\".
  echo
  read var_keyword2
  if [ -z "$var_keyword2" ]
    then
    echo
    echo Search in title with \""$var_keyword1"\" only.
    echo
    var_searchword=("Exit_search" $(grep -Erli --include='*.txt' "^t_itl_e.*"$var_keyword1"" | sort))
    if [ ${#var_searchword[@]} -lt "2" ]
      then
      echo
      echo No results found. Exiting.
      echo
    else
     select n in "${var_searchword[@]}"
     do
     if [ -z "$n" ]
       then
       echo Please, choose a number between 1 and "${#var_searchword[@]}".
     elif [ "$n" = "Exit_search" ]
       then
       break
     else
       var_note2show=$(sed -n '/t_itl_e/,/tt_a_gg/p' "$n" | sed -e 's/t_itl_e/TITLE/;s/^tt_a_gg.*//')
       #echo "$var_note2show" | less
       fn_file_action
       echo Press Enter
     fi
     done
    fi
  else
    echo
    echo Search with \""$var_keyword1"\" and \""$var_keyword2"\".
    echo
    var_searchword=("Exit_search" $(grep -Erli --include='*.txt' "^t_itl_e.*"$var_keyword1".*"$var_keyword2"|^t_itl_e.*"$var_keyword2".*"$var_keyword1"" | sort))
    if [ ${#var_searchword[@]} -lt "2" ]
      then
      echo
      echo No results found. Exiting.
      echo
    else
      select n in "${var_searchword[@]}"
      do
      if [ -z "$n" ]
        then
        echo Please, choose a number between 1 and "${#var_searchword[@]}".
      elif [ "$n" = "Exit_search" ]
        then
        break
      else
        echo
	var_note2show=$(sed -n '/t_itl_e/,/tt_a_gg/p' "$n" | sed -e 's/t_itl_e/TITLE/;s/^tt_a_gg.*//')
	#echo "$var_note2show" | less
        fn_file_action
        echo Press Enter
      fi
      done
    fi
  fi
fi

IFS=$OLDIFS

} # function to search in title

#echo
#echo "What do you want to do?"

while :
do
cat<<EOF
  ==============================
  What do you want to do?
  ------------------------------
  1) Exit the program
  2) Add a note
  3) Search by tag and view
  4) Search in title and view
  ==============================
EOF

echo
echo "Choose a number an press Enter."
echo

  read wtd 
    case "$wtd" in
	"1" ) exit;;
        "2" ) fn_note2add;;
        "3" ) fn_search_by_tag;;
	"4" ) fn_search_in_title;;
    esac
  
done

exit

