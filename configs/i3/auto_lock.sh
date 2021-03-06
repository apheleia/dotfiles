#!/bin/bash

# Dependencies
AWK=/usr/bin/awk
XPROP=/usr/bin/xprop

# Find active window id
get_active_id() {
    $XPROP -root | $AWK '$1 ~ /_NET_ACTIVE_WINDOW/ { print $5 }'
}

# Determine if a window is fullscreen based on it's ID
is_fullscreen() {
    $XPROP -id $1 | $AWK -F '=' '$1 ~ /_NET_WM_STATE\(ATOM\)/ { for (i=2; i<=3; i++) if ($i ~ /FULLSCREEN/) exit 0; exit 1 }'
    return $?
}

# Determine if the locker command should run based on which windows are
# fullscreened.
should_lock() {
    id=$(get_active_id)

    if is_fullscreen $id; then
        return 1
    else
        return 0
    fi
}

# main()
if should_lock; then
    ~/.config/i3/lock.sh
fi

