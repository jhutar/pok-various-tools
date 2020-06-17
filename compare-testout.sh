#!/bin/sh

if [ "$#" -eq 2 ]; then
    first=$1
    second=$2
else
    zenity_out=$( zenity --title "Provide logs" --forms --text "Please provide links to the TESTOUT.log files you want to compare" --add-entry "First log" --add-entry "Second log" )
    first=$( echo "$zenity_out" | cut -d '|' -f 1 )
    second=$( echo "$zenity_out" | cut -d '|' -f 2 )
fi

wget -O /tmp/first.log $first
wget -O /tmp/second.log $second

for f in /tmp/first.log /tmp/second.log; do
    sed -i 's/[A-Z][a-z]\{2\} [A-Z][a-z]\{2\} [ 1-3][0-9] [0-2][0-9]:[0-9]\{2\}:[0-9]\{2\} [A-Z]\+ 20[0-9]\{2\}/Day Mon DD HH:MM:SS TZNAME YYYY/g' $f
    sed -i 's/[A-Z][a-z]\{2\} [A-Z][a-z]\{2\} [ 1-3][0-9] [0-2][0-9]:[0-9]\{2\}:[0-9]\{2\} 20[0-9]\{2\}/Day Mon DD HH:MM:SS YYYY/g' $f
    sed -i 's/20[0-9]\{2\}[01][0-9][0-3][0-9]T[0-2][0-9]:[0-9]\{2\}:[0-9]\{2\}/YYYYMMDDTHH:MM:SS/g' $f
    sed -i 's/[0-2][0-9]:[0-9]\{2\}:[0-9]\{2\}/HH:MM:SS/g' $f
    sed -i 's/20[0-9]\{2\}-[01][0-9]-[0-3][0-9]/YYYY-MM-DD/g' $f
    sed -i 's/tmp\.[a-zA-Z0-9]\{10\}/tmp.XXXXXXXXXX/g' $f
    sed -i 's/tmp\.[a-zA-Z0-9]\{6\}/tmp.XXXXXX/g' $f
    sed -i 's/\/tmp\/[a-zA-Z0-9_-]\+\.[a-zA-Z0-9]\{6\}/tmp_TEMPFILE.XXXXXX/g' $f
    sed -i 's/:: \[ HH:MM:SS \] :: \[ INFO    \] :: Sending tmp_TEMPFILE.XXXXXX as [a-zA-Z0-9:._-]\+/:: [ HH:MM:SS ] :: [ INFO    ] :: Sending tmp_TEMPFILE.XXXXXX as BKR_TEMPFILE/g' $f
    sed -i 's/[a-zA-Z0-9]\{8\}-[a-zA-Z0-9]\{4\}-[a-zA-Z0-9]\{4\}-[a-zA-Z0-9]\{4\}-[a-zA-Z0-9]\{12\}/uuuuuuuu-uuuu-uuuu-uuuu-uuuuuuuuuuuu/g' $f
    sed -i 's/\/var\/tmp\/beakerlib-[0-9]\+\/journal\.txt/...journal.xml/g' $f
    sed -i 's/Searching AVC errors produced since [0-9]\{10\}\.[0-9][0-9]\?/Searching AVC errors produced since TIMESTAMP/g' $f
    sed -i '/^MARK-LWD-LOOP/d' $f
    sed -i 's/:: \[   LOG    \] :: Duration: [0-9].*/:: [   LOG    ] :: Duration: DURATION/g' $f
    sed -i 's/:: \[   LOG    \] :: Test run ID   : [0-9]\+/:: [   LOG    ] :: Test run ID   : TESTID/g' $f
    sed -i 's/[a-z0-9.-]\+.redhat.com/SOME_HOSTNAME/g' $f
    sed -i 's/Finish after [0-9]\+ seconds/Finish after DURATION seconds/g' $f
    sed -i 's/Examined \(.*\) for \(.*\): [0-9]\+ \/ [0-9]\+ = [0-9.]\+ (ranging from [0-9]\+ to [0-9]\+)/Examined \1 for \2: SUM \/ COUNT = AVG (ranging from START to END)/' $f
    sed -i '/^$/d' $f
done

gvimdiff /tmp/first.log /tmp/second.log
