#!/bin/bash

if ( (( $# == 1 )) && [ "$1" == "--help" ] ) || (( $# == 0 )); then
   echo "Script per la conversione da data in formato RFC822 a ISO8601"
   echo "NOTA: non tiene conto del fuso orario"
   echo ""
   echo "Utilizzo: $0 input_date"
   echo "  input_date	data in formato RFC822"
   echo ""
   echo "Es. $0 Nov 30, 2021 12:34:33 GMT"
   echo "  -> 2021-11-30T12:34:33Z"
   exit 0

fi

re='^[0-9]+$'
dre='^([0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]$'

IFS=" "
INDATE=($1)
unset IFS

DAY=${INDATE[1]}
MONTH=${INDATE[0]}
YEAR=${INDATE[3]}
TIME=${INDATE[2]}
TZ=${INDATE[4]}

function return_error {
   echo "Error parsing date: $1"
   exit 2
}

# Check Day
if ! [[ $DAY =~ $re ]]; then
   return_error "Day"
elif (( $DAY < 1 )) || (( $DAY > 31 )); then
   return_error "Day"
fi

# Check Year
if ! [[ $YEAR =~ $re ]]; then
   return_error "Year"
elif (( $YEAR < 1900 )) || (( $YEAR > 2999 )); then
   return_error "Year"
fi

# Check Time
if ! [[ $TIME =~ $dre ]]; then
   return_error "Time"
fi
#if ! [[ $MONTH =~ $mre ]]; then
#   return_error "Month"
#fi



# Convert Month
case $MONTH in
   Jan)
      MONTH=01
      ;;
   Feb)
      MONTH=02
      if (( $YEAR % 400 == 0 )) || ( (( $YEAR % 100 != 0 )) && (( $YEAR % 4 == 0 )) ); then
          if (( $DAY > 29 )); then
             return_error "Day"
          elif (( $DAY > 28 )); then
             return_error "Day"
          fi
      fi
      ;;
   Mar)
      MONTH=03
      ;;
   Apr)
      MONTH=04
      if (( $DAY > 30 )); then
	return_error "Day"
      fi
      ;;
   May)
      MONTH=05
      ;;
   Jun)
      MONTH=06
      if (( $DAY > 30 )); then
        return_error "Day"
      fi
      ;;
   Jul)
      MONTH=07
      ;;
   Ago)
      MONTH=08
      ;;
   Sep)
      MONTH=09
      if (( $DAY > 30 )); then
        return_error "Day"
      fi
      ;;
   Oct)
      MONTH=10
      ;;
   Nov)
      MONTH=11
      if (( $DAY > 30 )); then
        return_error "Day"
      fi
      ;;
   Dec)
      MONTH=12
      ;;
   *)
      return_error "Month"
      ;;
esac

echo "$YEAR-$MONTH-$DAY"T"$TIME"Z
