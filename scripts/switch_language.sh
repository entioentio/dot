#!/bin/bash

(setxkbmap -query | grep -q "layout:\s\+pl") && setxkbmap us || setxkbmap pl