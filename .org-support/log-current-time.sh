LOG_ENTRY=`date +"--[%Y-%m-%d %a %H:%M]"`

LOG_FILE=~/.org-support/org-screen-saver.log
MAX_LOG_SIZE=10

touch $LOG_FILE

CURRENT_NUMBER_OF_LINES=$(wc -l < $LOG_FILE | sed -e 's/^[ \t]*//')

if [[ $CURRENT_NUMBER_OF_LINES -gt MAX_LOG_SIZE ]]
then
	NUMBER_OF_LINES_TO_KEEP=$(($MAX_LOG_SIZE / 2))
	LAST_ENTRIES=$(tail -n $NUMBER_OF_LINES_TO_KEEP < $LOG_FILE)
	echo "$LAST_ENTRIES" > $LOG_FILE
fi

echo "$LOG_ENTRY" >> $LOG_FILE
