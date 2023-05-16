#!/bin/sh

COLOR_OVERDUE='#f2777a'
COLOR_TODAY='#f99157'
COLOR_WEEK='#ffcc66'
COLOR_OK='#99cc99'

CHAR_OVERDUE=' '
CHAR_TODAY='󰃶 '
CHAR_WEEK='󰨳 '

NUM_OVERDUE=$(task +OVERDUE count 2> /dev/null)
NUM_TODAY=$(task +PENDING +DUETODAY -OVERDUE count 2> /dev/null)
NUM_WEEK=$(task +PENDING +WEEK -DUETODAY count 2> /dev/null)

if [[ $NUM_OVERDUE -eq 0 && $NUM_TODAY -eq 0 && $NUM_WEEK -eq 0 ]]; then
	echo "{\"text\": \" \", \"class\": \"ok\"}"
fi

if [ $NUM_OVERDUE -gt 0 ]; then
	echo "{\"text\": \"[ $CHAR_OVERDUE $NUM_OVERDUE ]\", \"class\": \"overdue\"}"
fi

if [ $NUM_TODAY -gt 0 ]; then
	echo "{\"text\":\"[ $CHAR_TODAY $NUM_TODAY ]\",\"class\": \"today\"}"
fi

if [ $NUM_WEEK -gt 0 ]; then
	echo "{\"text\": \"[ $CHAR_WEEK $NUM_WEEK ]\", \"class\": \"week\"}"
fi
