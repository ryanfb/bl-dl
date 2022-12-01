#!/bin/bash

wget -O - "$1" | fgrep 'id="PageList"' | sed -e 's/^.*value="//' -e 's/" \/>.*//' -e "s/||/\n/g" | grep -v '^##$' | sort | uniq | while read i; do echo "$i"; dezoomify-rs -r 10 --timeout 60s -l "http://www.bl.uk/manuscripts/Proxy.ashx?view=${i}.xml" "${i}.jpg"; done
