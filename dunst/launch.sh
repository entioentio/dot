#!/bin/sh

# Terminate already running bar instances
killall -q dunst

dunst -conf ~/.config/dunst/dunstrc
