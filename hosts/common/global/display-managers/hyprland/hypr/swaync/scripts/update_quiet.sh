#!/usr/bin/env bash

if powerprofilesctl get | grep -q "power-saver"; then
    echo true
else
    echo false
fi
