#!/bin/bash

SYNC_ROOT="${SYNC_ROOT:-$HOME/Nextcloud}"
DOWNLOADS_DIR="${DOWNLOADS_DIR:-$HOME/Downloads}"

idle=false
newjob=false
pid=-1
idleAfter=3600000 # 60 minutes
readarray -t workdirs < <(find "$SYNC_ROOT" -maxdepth 1 -type d -printf '%p\n')
workdirs[0]="$DOWNLOADS_DIR"
workdir="${workdirs[$(($RANDOM%"${#workdirs[@]}"))]}"

while true; do
  #echo $(date) > "$HOME/Desktop/debug.log"
  idleTimeMillis=$(xprintidle)
  batStatus=$(cat /sys/class/power_supply/BAT1/status)
  #echo idleTimeMillis: $idleTimeMillis
  #echo batStatus: $batStatus
  #echo pid: $pid
  if ! $idle || $newjob ; then
      if [[ $idleTimeMillis -gt $idleAfter && $batStatus != "Discharging" ]] ; then
        # Start idle
        #echo idle
        workdir="${workdirs[$(($RANDOM%"${#workdirs[@]}"))]}"
        #echo "Working on : $workdir ("${#workdirs[@]}" workdirs left)"
        find "$workdir" -type f -exec mat2 --inplace --lightweight {} \; >/dev/null &
        pid=$!
        idle=true
        newjob=false
      fi
  fi

  if [[ $idle = true && $idleTimeMillis -lt $idleAfter ]] ; then
    # kill idle
    #echo not idle
    kill $pid
    idle=false
    newjob=false
    unset workdirs
    readarray -t workdirs < <(find "$SYNC_ROOT" -maxdepth 1 -type d -printf '%p\n')
    workdirs[0]="$DOWNLOADS_DIR"
    #echo "Not idle, reset workdirs : "${#workdirs[@]}""
  fi

  sleep 1      # polling interval (in seconds)

  if [[ $idle = true && $newjob = false ]] ; then
    if ! ps -p $pid > /dev/null ; then
        #echo "Finished, removing : $workdir"
        new_array=()
        for value in "${workdirs[@]}"
        do
            [[ $value != $workdir ]] && new_array+=($value)
        done
        workdirs=("${new_array[@]}")
        unset new_array
        if [ ${#workdirs[@]} -gt 0 ]; then
            newjob=true
        fi
    fi
  fi

done
