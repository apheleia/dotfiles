#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar(s)
echo "---" | tee -a /tmp/polybar1.log
polybar bar1 >>/tmp/polybar1.log 2>&1 & disown
#polybar bar2 >>/tmp/polybar2.log 2>&1 & disown

echo "Bars launched..."
