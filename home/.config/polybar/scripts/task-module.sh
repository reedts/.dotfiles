#!/bin/sh

COLOR_OVERDUE='#f2777a'
COLOR_TODAY='#f99157'
COLOR_WEEK='#ffcc66'
COLOR_OK='#99cc99'

NUMBER_FONT='T4'

CHAR_OVERDUE=''
CHAR_TODAY=''
CHAR_WEEK='ﭷ'

NUM_OVERDUE=$(task +OVERDUE count 2> /dev/null)
NUM_TODAY=$(task +PENDING +DUETODAY -OVERDUE count 2> /dev/null)
NUM_WEEK=$(task +PENDING +WEEK -DUETODAY count 2> /dev/null)

if [[ $NUM_OVERDUE -eq 0 && $NUM_TODAY -eq 0 && $NUM_WEEK -eq 0 ]]; then
	echo -n "%{F$COLOR_OK}%{F-}"
fi

if [ $NUM_OVERDUE -gt 0 ]; then
	echo -n "%{F$COLOR_OVERDUE}[ $CHAR_OVERDUE %{$NUMBER_FONT}$NUM_OVERDUE%{T-} ]%{F-} "
fi

if [ $NUM_TODAY -gt 0 ]; then
	echo -n "%{F$COLOR_TODAY}[ $CHAR_TODAY %{$NUMBER_FONT}$NUM_TODAY%{T-} ]%{F-} "
fi

if [ $NUM_WEEK -gt 0 ]; then
	echo -n "%{F$COLOR_WEEK}[ $CHAR_WEEK %{$NUMBER_FONT}$NUM_WEEK%{T-} ]%{F-}"
fi

echo ""
